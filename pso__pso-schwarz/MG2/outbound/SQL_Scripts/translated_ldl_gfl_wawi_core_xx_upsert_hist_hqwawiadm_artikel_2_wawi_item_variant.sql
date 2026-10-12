CREATE OR REPLACE TEMP TABLE wawi_items_with_deletion_range AS 
(
    WITH wawi_items_with_deleted_dt AS (
    /* Already deleted items */
    SELECT DISTINCT
        left(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
        CASE 
          WHEN length(c920_itemnr_short) = 11 /* orig_item_nr(7) || case_size(4) */
            THEN SAFE_CAST(substr(c920_itemnr_short,1,7) AS INT64)
          ELSE coalesce(
                 SAFE_CAST(c920_itemnr_short AS INT64),
                 SAFE_CAST(ltrim(ltrim(c920_itemnr_short, '0'), ' ') AS INT64) --?
               )
        END AS orig_item_nr,
        SAFE_CAST(c920_moddate AS DATE) AS deleted_dt,
        null AS min_gueltig_ab
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t920_delitems
    WHERE coalesce(
            SAFE_CAST(c920_itemnr_short AS INT64),
            SAFE_CAST(ltrim(ltrim(c920_itemnr_short, '0'), ' ') AS INT64) --?
          ) IS NOT NULL
      AND delete_fg IS NULL

    UNION ALL

    /* Currently active items */
    SELECT
        left(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
        SAFE_CAST(artnrvier AS INT64) AS orig_item_nr,
        DATE '9999-12-31' AS deleted_dt,
        MIN(gueltig_ab) AS min_gueltig_ab
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel
    WHERE delete_fg IS NULL
    GROUP BY 1,2
),
wawi_items_with_deleted_dt_cses AS (
    /* For item numbers existing in both CS and ES, use only the part FROM ES -- removed */
    SELECT *
    FROM wawi_items_with_deleted_dt
    /*QUALIFY Max(wawi_instanz_kzl) OVER (PARTITION BY CASE WHEN wawi_instanz_kzl = 'CS' THEN 'ES' ELSE wawi_instanz_kzl END
                                          , orig_item_nr)
            = wawi_instanz_kzl*/
)
),
wawi_items_with_range AS (
    SELECT
        left(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
        orig_item_nr,
        coalesce(
            lag(deleted_dt) OVER (PARTITION BY wawi_instanz_kzl, orig_item_nr ORDER BY deleted_dt) + 1,
            DATE '1900-01-01'
        ) AS wawi_item_prev_deleted_dt,
        deleted_dt AS wawi_item_deleted_dt,
        min_gueltig_ab
    FROM wawi_items_with_deleted_dt_cses
)
SELECT del.*,
       CASE WHEN wawi_instanz_kzl = 'CS' THEN 'ES' ELSE left(wawi_instanz_kzl,2) END AS country,
       prev_keys.wawi_item_nat_key_nr,
       prev_keys.dwh_valid_from_tmsp AS prev_dwh_valid_from_tmsp
FROM wawi_items_with_range AS del
LEFT JOIN ldl_data_production_meta.t_wawi_item_key prev_keys --check if key already exists
  ON CASE WHEN wawi_instanz_kzl='CS' THEN 'ES' ELSE left(wawi_instanz_kzl,2) END
     = split(prev_keys.wawi_item_nat_key_nr,'|')[OFFSET(0)]
 AND del.orig_item_nr = SAFE_CAST(split(prev_keys.wawi_item_nat_key_nr,'|')[OFFSET(1)] AS INT64)
 AND prev_keys.dwh_valid_fg=TRUE
QUALIFY row_number() OVER (PARTITION BY country, orig_item_nr, wawi_item_deleted_dt ORDER BY wawi_instanz_kzl DESC) = 1
);


--If an item is existing in previous Meta table with valid_FROM less than last deleted date, and comes in new artikel source with gueltig_ab greater than last deleted dt, generate new sid
CREATE OR REPLACE TEMP TABLE wawi_item_new_upd_wawi_item_keys AS 
(
SELECT 
    country,
    orig_item_nr,
    min_gueltig_ab
FROM wawi_items_with_deletion_range
WHERE wawi_item_deleted_dt = DATE '9999-12-31'
  AND (
        wawi_item_nat_key_nr IS NULL --completely new items
        OR (
            wawi_item_prev_deleted_dt <> DATE '1900-01-01' --the last deletion date is not null 
            AND min_gueltig_ab > wawi_item_prev_deleted_dt --gueltig_ab bigger than last deletion date
            AND wawi_item_prev_deleted_dt >= prev_dwh_valid_from_tmsp --the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT dwh_valid_FROM (gueltig_ab)
           )
      );
);


--If an item variant is existing in previous Meta table with valid_FROM less than last deleted date, and comes in new artikel source with gueltig_ab greater than last deleted dt, generate new sid
CREATE OR REPLACE TEMP TABLE t_wawi_precore_item_variant_temp AS 
(
SELECT 
    CASE WHEN a.wawi_instanz_kzl='CS' THEN 'ES' ELSE left(a.wawi_instanz_kzl,2) END AS country_es_cs,
    SAFE_CAST(artnrvier AS INT64) AS itemnr,
    SAFE_CAST(right(artikelnr,4) AS INT64) AS src_case_size,
    country_es_cs || '|' || itemnr || '|' || src_case_size AS wawi_item_variant_nat_key_nr,
    a.*,
    wawi_item_prev_deleted_dt,
    wawi_item_deleted_dt
FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel AS a
JOIN wawi_items_with_deletion_range b
  ON country_es_cs = b.country
 AND itemnr = b.orig_item_nr
 AND b.wawi_item_deleted_dt = DATE '9999-12-31' --filter to pick only the correct ES/CS items
WHERE a.delete_fg IS NULL        
QUALIFY row_number() OVER (
    PARTITION BY country_es_cs || '|' || itemnr || '|' || src_case_size
    ORDER BY a.wawi_instanz_kzl DESC, artikelnr ASC, extraction_tmsp DESC
) = 1 --pick the latest data. Chose ES variant over CS variant
);

CREATE OR REPLACE TEMP TABLE wawi_item_new_upd_wawi_item_variant_keys AS 
(
SELECT 
    a.wawi_item_variant_nat_key_nr,
    a.gueltig_ab
FROM t_wawi_precore_item_variant_temp a
LEFT JOIN ldl_data_production_meta.t_wawi_item_variant_key prev_keys 
  ON country_es_cs = split(prev_keys.wawi_item_variant_nat_key_nr,'|')[OFFSET(0)]
 AND a.itemnr = SAFE_CAST(split(prev_keys.wawi_item_variant_nat_key_nr,'|')[OFFSET(1)] AS INT64)
 AND a.src_case_size = SAFE_CAST(split(prev_keys.wawi_item_variant_nat_key_nr,'|')[OFFSET(2)] AS INT64)
 AND prev_keys.dwh_valid_fg=TRUE
WHERE wawi_item_deleted_dt='9999-12-31' 
  AND (
        prev_keys.wawi_item_variant_nat_key_nr IS NULL --completely new item variants
        OR (
            a.wawi_item_prev_deleted_dt <> DATE '1900-01-01' --the last deletion date is not null 
            AND gueltig_ab > a.wawi_item_prev_deleted_dt --gueltig_ab bigger than last deletion date
            AND a.wawi_item_prev_deleted_dt >= prev_keys.dwh_valid_from_tmsp --the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT dwh_valid_FROM (gueltig_ab)
           )
      );
);

BEGIN TRANSACTION;

DELETE FROM ldl_data_production_meta.t_wawi_item_key WHERE FALSE; --lock the whole table
DELETE FROM ldl_data_production_meta.t_wawi_item_variant_key WHERE FALSE; --lock the whole table

UPDATE ldl_data_production_meta.t_wawi_item_key x
--should produce 0, the keys should be already generated by xx_upsert_hist_wawi_precore_artikel_2_wawi_item.pset
SET
  dwh_valid_fg = FALSE,
  dwh_valid_to_tmsp = timestamp_sub(y.min_gueltig_ab, INTERVAL 1 MICROSECOND),
  dwh_updated_tmsp = current_timestamp(),
  dwh_load_id = '${LOAD_ID}',
  dwh_node_cd = 'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_keys y
WHERE concat(y.country,'|',y.orig_item_nr) = x.wawi_item_nat_key_nr
  AND x.dwh_valid_fg = TRUE;

INSERT INTO ldl_data_production_meta.t_wawi_item_key
SELECT
    z.max_sid + row_number() OVER (ORDER BY concat(y.country,'|',y.orig_item_nr)) AS wawi_item_sid,
    'WAWI',
    y.min_gueltig_ab,
    TIMESTAMP('9999-12-31 23:59:59 UTC'),
    TRUE,
    concat(y.country,'|',y.orig_item_nr),
    current_timestamp(),
    current_timestamp(),
    '${LOAD_ID}',
    'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_keys y
CROSS JOIN (SELECT COALESCE(MAX(wawi_item_sid),0) AS max_sid FROM ldl_data_production_meta.t_wawi_item_key) z;

UPDATE ldl_data_production_meta.t_wawi_item_variant_key x
SET
  dwh_valid_fg = FALSE,
  dwh_valid_to_tmsp = timestamp_sub(y.gueltig_ab, INTERVAL 1 MICROSECOND),
  dwh_updated_tmsp = current_timestamp(),
  dwh_load_id = '${LOAD_ID}',
  dwh_node_cd = 'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_variant_keys y
WHERE y.wawi_item_variant_nat_key_nr = x.wawi_item_variant_nat_key_nr
  AND x.dwh_valid_fg=TRUE;

INSERT INTO ldl_data_production_meta.t_wawi_item_variant_key
SELECT
    z.max_sid + row_number() OVER (ORDER BY y.wawi_item_variant_nat_key_nr) AS wawi_item_variant_sid,
    'WAWI',
    y.gueltig_ab,
    TIMESTAMP('9999-12-31 23:59:59 UTC'),
    TRUE,
    wawi_item_variant_nat_key_nr,
    current_timestamp(),
    current_timestamp(),
    '${LOAD_ID}',
    'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_variant_keys y
CROSS JOIN (SELECT COALESCE(MAX(wawi_item_variant_sid),0) AS max_sid FROM ldl_data_production_meta.t_wawi_item_variant_key) z;

COMMIT;

INSERT INTO ldl_data_production_${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
    wawi_item_nat_key_nr,
    wawi_item_key_type_cd,
    wawi_item_variant_key_type_cd,
    wawi_item_variant_nat_key_nr,
    country_org_nat_key,
    country_org_key_type_cd,
    country_org_cd,
    wawi_item_variant_nr,
    wawi_item_variant_name,
    wawi_item_variant_descr,
    wawi_item_variant_creation_dt,
    case_size_cnt,
    weight_based_fg,
    -- FRAMEWORK AND TECHNICAL COLUMNS
    source_system,
    extraction_dt,
    dwh_mapping_tmsp,
    tf_error_fg,
    deleted_fg,
    record_id,
    filename,
    dwh_node_cd,
    dwh_load_id
)
SELECT
    concat(art.country_es_cs,'|',ltrim(artnrvier,'0')) AS wawi_item_nat_key_nr,
    'WAWI' AS wawi_item_key_type_cd,
    'WAWI' AS wawi_item_variant_key_type_cd,
    concat(art.country_es_cs,'|',art.itemnr,'|',art.src_case_size) AS wawi_item_variant_nat_key_nr,
    art.country_es_cs AS country_org_nat_key,
    'COUNTRY' AS country_org_key_type_cd,
    art.country_es_cs AS country_org_cd,
    art.artikelnr AS wawi_item_variant_nr,
    trim(coalesce(deutschtext,bez_lang,'Unbekannt')) AS wawi_item_variant_name,
    trim(art.bez_lang) AS wawi_item_variant_descr,
    art.gueltig_ab AS wawi_item_variant_creation_dt,
    right(art.artikelnr,4) AS case_size_cnt,
    coalesce(itmo.weight_based_fg,0) AS weight_based_fg, --?
    'WAWI' AS source_system,
    art.extraction_tmsp AS extraction_dt,
    art.extraction_tmsp AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    '${SRC_INPUT_TABLE}' AS filename,
    'WAWI_HQ' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
FROM t_wawi_precore_item_variant_temp art
LEFT JOIN (
    SELECT
        left(wawi_instanz_kzl,2) AS wawi_instanz_kzl,
        SAFE_CAST(substr(artikelnr,1,length(artikelnr)-4) AS INT64) AS artikelnr,
        max(CASE WHEN gewichtsartikel=1 THEN TRUE ELSE FALSE END) AS weight_based_fg
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikelbestell
    WHERE delete_fg IS NULL
    GROUP BY 1,2
) itmo
  ON art.wawi_instanz_kzl = itmo.wawi_instanz_kzl
 AND art.itemnr = itmo.artikelnr
;
