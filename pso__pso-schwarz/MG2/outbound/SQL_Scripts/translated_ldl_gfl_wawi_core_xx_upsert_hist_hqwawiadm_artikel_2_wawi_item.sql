CREATE OR REPLACE TEMP TABLE wawi_items_with_deletion_range AS
(
    WITH wawi_items_with_deleted_dt AS (
    /* Already deleted items */
    SELECT DISTINCT
        left(wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
        CASE 
            WHEN length(c920_itemnr_short) = 11 /* orig_item_nr(7) || case_size(4) */
            THEN SAFE_CAST(substr(c920_itemnr_short, 1, 7) AS INT64)
            ELSE coalesce(
                 SAFE_CAST(c920_itemnr_short AS INT64),
                 SAFE_CAST(ltrim(ltrim(c920_itemnr_short, '0'), ' ') AS INT64) --?
            )
        END AS orig_item_nr,
        SAFE_CAST(c920_moddate AS DATE) AS deleted_dt,
        NULL AS min_gueltig_ab
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t920_delitems
    WHERE coalesce(
              SAFE_CAST(c920_itemnr_short AS INT64),
              SAFE_CAST(ltrim(ltrim(c920_itemnr_short, '0'), ' ') AS INT64) --?
          ) IS NOT NULL
      AND delete_fg IS NULL

    UNION ALL

    /* Currently active items */
    SELECT
        left(wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
        SAFE_CAST(artnrvier AS INT64) AS orig_item_nr,
        DATE '9999-12-31' AS deleted_dt,
        min(gueltig_ab) AS min_gueltig_ab
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel
    GROUP BY 1, 2
),
wawi_items_with_deleted_dt_cses AS (
    /* For item numbers existing in both CS and ES, use only the part from ES -- removed */
    SELECT *
    FROM wawi_items_with_deleted_dt
    /*QUALIFY Max(wawi_instanz_kzl) OVER (PARTITION BY CASE WHEN wawi_instanz_kzl = 'CS' THEN 'ES' ELSE wawi_instanz_kzl END
                                          , orig_item_nr)
            = wawi_instanz_kzl*/
),
wawi_items_with_range AS (
    SELECT
        left(wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
        orig_item_nr,
        coalesce(
            lag(deleted_dt) OVER (PARTITION BY wawi_instanz_kzl, orig_item_nr ORDER BY deleted_dt) + 1,
            DATE '1900-01-01'
        ) AS wawi_item_prev_deleted_dt,
        deleted_dt AS wawi_item_deleted_dt,
        min_gueltig_ab
    FROM wawi_items_with_deleted_dt_cses AS wi
)
SELECT
    del.*,
    CASE WHEN wawi_instanz_kzl = 'CS' THEN 'ES' ELSE left(wawi_instanz_kzl, 2) END AS country,
    prev_keys.wawi_item_nat_key_nr,
    prev_keys.dwh_valid_from_tmsp AS prev_dwh_valid_from_tmsp
FROM wawi_items_with_range AS del
LEFT JOIN ldl_data_production_meta.t_wawi_item_key prev_keys
  ON    --check if key already exists
  CASE WHEN wawi_instanz_kzl = 'CS' THEN 'ES' ELSE left(wawi_instanz_kzl, 2) END
     = split(prev_keys.wawi_item_nat_key_nr, '|')[OFFSET(0)]
 AND del.orig_item_nr = SAFE_CAST(split(prev_keys.wawi_item_nat_key_nr, '|')[OFFSET(1)] AS INT64)
 AND prev_keys.dwh_valid_fg = TRUE
QUALIFY row_number() OVER (
    PARTITION BY country, orig_item_nr, wawi_item_deleted_dt
    ORDER BY wawi_instanz_kzl DESC
) = 1
);


--If an item is existing in previous Meta table with valid_from less than last deleted date, and comes in new artikel source with gueltig_ab greater than last deleted dt, generate new sid

CREATE OR REPLACE TEMP TABLE wawi_item_new_upd_wawi_item_keys AS
(
SELECT
    country,
    orig_item_nr,
    min_gueltig_ab,
    (wawi_item_nat_key_nr IS NULL) AS first_instance_fg --First instance of a NK will get additionally the 1900-01-01 record
FROM wawi_items_with_deletion_range
WHERE wawi_item_deleted_dt = DATE '9999-12-31'
  AND (
      wawi_item_nat_key_nr IS NULL --completely new items
      OR  (wawi_item_prev_deleted_dt <> DATE '1900-01-01' --the last deletion date is not null
          AND min_gueltig_ab > wawi_item_prev_deleted_dt --gueltig_ab bigger than last deletion date
          AND wawi_item_prev_deleted_dt >= prev_dwh_valid_from_tmsp) --the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT dwh_valid_from (gueltig_ab)
     )
);


--If an item has already arrived from master data and its SID was generated outside of WAWI-item transformation,
--we continue to use already generated SID
CREATE OR REPLACE TEMP TABLE wawi_item_dummy_key_upd AS
(
SELECT
    wik.wawi_item_sid,
    wik.wawi_item_key_type_cd,
    CASE WHEN seq.seq_num = 0
         THEN TIMESTAMP('1900-01-01 00:00:00 UTC')
         ELSE wi.min_gueltig_ab
    END AS dwh_valid_from_tmsp,
    CASE WHEN seq.seq_num = 0
         THEN TIMESTAMP_SUB(wi.min_gueltig_ab, INTERVAL 1 MICROSECOND)
         ELSE TIMESTAMP('9999-12-31 23:59:59 UTC')
    END AS dwh_valid_to_tmsp,
    (seq.seq_num = 1) AS dwh_valid_fg,
    wik.wawi_item_nat_key_nr
FROM wawi_items_with_deletion_range AS wi
JOIN ldl_data_production_meta.t_wawi_item_key AS wik
  ON wi.country || '|' || wi.orig_item_nr = wik.wawi_item_nat_key_nr
 AND wik.wawi_item_key_type_cd = 'WAWI'
 AND wik.dwh_valid_fg = TRUE
JOIN ldl_data_production_core_rel.t_wawi_item AS i
  ON wik.wawi_item_sid = i.wawi_item_sid
 AND i.dwh_valid_fg = TRUE
 AND i.wawi_item_creation_dt = DATE '1900-01-01'
CROSS JOIN UNNEST([0,1]) AS seq(seq_num)
);


--If an item variant is existing in previous Meta table with valid_from less than last deleted date, and comes in new artikel source with gueltig_ab greater than last deleted dt, generate new sid
CREATE OR REPLACE TEMP TABLE t_wawi_precore_item_variant_temp AS
(
SELECT
    CASE WHEN a.wawi_instanz_kzl='CS' THEN 'ES' ELSE left(a.wawi_instanz_kzl, 2) END AS country_es_cs,
    SAFE_CAST(artnrvier AS INT64) AS itemnr,
    SAFE_CAST(right(artikelnr, 4) AS INT64) AS src_case_size,
    country_es_cs || '|' || itemnr || '|' || src_case_size AS wawi_item_variant_nat_key_nr,
    a.*,
    wawi_item_prev_deleted_dt,
    wawi_item_deleted_dt
FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel AS a
JOIN wawi_items_with_deletion_range b
  ON CASE WHEN a.wawi_instanz_kzl='CS' THEN 'ES' ELSE left(a.wawi_instanz_kzl,2) END = b.country
 AND SAFE_CAST(artnrvier AS INT64) = b.orig_item_nr
 AND b.wawi_item_deleted_dt = DATE '9999-12-31' --filter to pick only the correct ES/CS items
QUALIFY row_number() OVER (
    PARTITION BY country_es_cs || '|' || itemnr || '|' || src_case_size
    ORDER BY a.wawi_instanz_kzl DESC, artikelnr ASC, extraction_tmsp DESC
) = 1 --pick the latest data. Chose ES variant over CS variant. The sorting by artikelnr is for the code to always pick the same item variant
);

CREATE OR REPLACE TEMP TABLE wawi_item_new_upd_wawi_item_variant_keys AS
(
SELECT
    A.wawi_item_variant_nat_key_nr,
    A.gueltig_ab,
    --First instance of a NK will get additionally the 1900-01-01 record
    (prev_keys.wawi_item_variant_nat_key_nr IS NULL) AS first_instance_fg,
    --Variant with lowest case size will use the dummy SID if it exists
    (dvk.wawi_item_variant_sid IS NOT NULL
     AND ROW_NUMBER() OVER (PARTITION BY A.country_es_cs, A.itemnr ORDER BY A.src_case_size) = 1
    ) AS dummy_sid_reuse_fg,
    CASE WHEN ROW_NUMBER() OVER (PARTITION BY A.country_es_cs, A.itemnr ORDER BY A.src_case_size) = 1
         THEN dvk.wawi_item_variant_sid
         ELSE NULL
    END AS wawi_item_variant_sid
FROM t_wawi_precore_item_variant_temp A
LEFT JOIN ldl_data_production_meta.t_wawi_item_variant_key prev_keys
  ON A.country_es_cs = split(prev_keys.wawi_item_variant_nat_key_nr,'|')[OFFSET(0)]
 AND A.itemnr = SAFE_CAST(split(prev_keys.wawi_item_variant_nat_key_nr,'|')[OFFSET(1)] AS INT64)
 AND A.src_case_size = SAFE_CAST(split(prev_keys.wawi_item_variant_nat_key_nr,'|')[OFFSET(2)] AS INT64)
 AND prev_keys.dwh_valid_fg = TRUE
LEFT JOIN wawi_item_dummy_key_upd dik
  ON A.country_es_cs || '|' || A.itemnr = dik.wawi_item_nat_key_nr
 AND dik.dwh_valid_fg = TRUE
LEFT JOIN ldl_data_production_meta.t_wawi_item_variant_key dvk
  ON dik.wawi_item_nat_key_nr || '|0' = dvk.wawi_item_variant_nat_key_nr
 AND dvk.dwh_valid_fg = TRUE
WHERE wawi_item_deleted_dt = DATE '9999-12-31'
  AND (
        prev_keys.wawi_item_variant_nat_key_nr IS NULL --completely new item variants
     OR (
         A.wawi_item_prev_deleted_dt <> DATE '1900-01-01' --the last deletion date is not null
         AND gueltig_ab > A.wawi_item_prev_deleted_dt --gueltig_ab bigger than last deletion date
         AND A.wawi_item_prev_deleted_dt >= prev_keys.dwh_valid_from_tmsp --the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT dwh_valid_from (gueltig_ab)
        )
      )
);


BEGIN TRANSACTION;

-- lock the whole table
DELETE FROM ldl_data_production_meta.t_wawi_item_key WHERE FALSE;

-- lock the whole table
DELETE FROM ldl_data_production_meta.t_wawi_item_variant_key WHERE FALSE;

-- Keep using the dummy generated SID in case when the NK (country, itemnr) is delivered in item data
MERGE INTO ldl_data_production_meta.t_wawi_item_key AS tgt
USING wawi_item_dummy_key_upd AS src
ON tgt.wawi_item_sid = src.wawi_item_sid
AND tgt.dwh_valid_from_tmsp = src.dwh_valid_from_tmsp
WHEN MATCHED THEN
  UPDATE SET
    dwh_valid_to_tmsp = src.dwh_valid_to_tmsp,
    dwh_valid_fg = src.dwh_valid_fg,
    dwh_updated_tmsp = CURRENT_TIMESTAMP(),
    dwh_load_id = '${LOAD_ID}'
WHEN NOT MATCHED THEN
  INSERT (
    wawi_item_sid,
    wawi_item_key_type_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    dwh_valid_fg,
    wawi_item_nat_key_nr,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
  )
  VALUES (
    src.wawi_item_sid,
    src.wawi_item_key_type_cd,
    src.dwh_valid_from_tmsp,
    src.dwh_valid_to_tmsp,
    src.dwh_valid_fg,
    src.wawi_item_nat_key_nr,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP(),
    '${LOAD_ID}',
    'WAWI_HQ'
  );


UPDATE ldl_data_production_meta.t_wawi_item_key AS x
--should produce 0, the keys should be already generated by xx_upsert_hist_wawi_precore_artikel_2_wawi_item.pset
SET
  dwh_valid_fg = FALSE,
  dwh_valid_to_tmsp = TIMESTAMP_SUB(y.min_gueltig_ab, INTERVAL 1 MICROSECOND),
  dwh_updated_tmsp = CURRENT_TIMESTAMP(),
  dwh_load_id = '${LOAD_ID}',
  dwh_node_cd = 'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_keys AS y
WHERE CONCAT(y.country, '|', y.orig_item_nr) = x.wawi_item_nat_key_nr
  AND x.dwh_valid_fg = TRUE;


INSERT INTO ldl_data_production_meta.t_wawi_item_key (
  wawi_item_sid,
  wawi_item_key_type_cd,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  wawi_item_nat_key_nr,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
)
SELECT
  max_sid + ROW_NUMBER() OVER (ORDER BY y.country || '|' || y.orig_item_nr) AS wawi_item_sid,
  'WAWI',
  y.min_gueltig_ab,
  TIMESTAMP '9999-12-31 23:59:59 UTC',
  TRUE,
  CONCAT(y.country, '|', y.orig_item_nr),
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  '${LOAD_ID}',
  'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_keys AS y  -- First generate new SIDs
CROSS JOIN (
  SELECT COALESCE(MAX(wawi_item_sid), 0) AS max_sid
  FROM ldl_data_production_meta.t_wawi_item_key
) AS z;


-- Use the SID given to the dummy variant for the variant with lowest case size
-- when item is delivered
UPDATE ldl_data_production_meta.t_wawi_item_variant_key AS tgt
SET
  dwh_valid_fg = FALSE,
  dwh_valid_to_tmsp = TIMESTAMP_SUB(src.gueltig_ab, INTERVAL 1 MICROSECOND),
  wawi_item_variant_nat_key_nr = src.wawi_item_variant_nat_key_nr,
  dwh_updated_tmsp = CURRENT_TIMESTAMP(),
  dwh_load_id = '${LOAD_ID}'
FROM wawi_item_new_upd_wawi_item_variant_keys AS src
WHERE tgt.wawi_item_variant_sid = src.wawi_item_variant_sid
  AND src.dummy_sid_reuse_fg = TRUE;

-- Insert reused variant keys
INSERT INTO ldl_data_production_meta.t_wawi_item_variant_key (
  wawi_item_variant_sid,
  wawi_item_variant_key_type_cd,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  wawi_item_variant_nat_key_nr,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
)
SELECT
  wawi_item_variant_sid,
  'WAWI',
  gueltig_ab,
  TIMESTAMP '9999-12-31 23:59:59 UTC',
  TRUE,
  wawi_item_variant_nat_key_nr,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  '${LOAD_ID}',
  'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_variant_keys
WHERE dummy_sid_reuse_fg = TRUE;

-- Invalidate old variant keys
UPDATE ldl_data_production_meta.t_wawi_item_variant_key AS x
SET
  dwh_valid_fg = FALSE,
  dwh_valid_to_tmsp = TIMESTAMP_SUB(y.gueltig_ab, INTERVAL 1 MICROSECOND),
  dwh_updated_tmsp = CURRENT_TIMESTAMP(),
  dwh_load_id = '${LOAD_ID}',
  dwh_node_cd = 'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_variant_keys AS y
WHERE y.wawi_item_variant_nat_key_nr = x.wawi_item_variant_nat_key_nr
  AND x.dwh_valid_fg = TRUE
  AND y.dummy_sid_reuse_fg = FALSE;

-- Insert new variant keys
INSERT INTO ldl_data_production_meta.t_wawi_item_variant_key (
  wawi_item_variant_sid,
  wawi_item_variant_key_type_cd,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  wawi_item_variant_nat_key_nr,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
)
SELECT
  src.wawi_item_variant_sid,
  'WAWI',
  CASE WHEN seq.seq_num = 0
       THEN TIMESTAMP '1900-01-01 00:00:00 UTC'
       ELSE src.gueltig_ab
  END,
  CASE WHEN seq.seq_num = 0
       THEN TIMESTAMP_SUB(src.gueltig_ab, INTERVAL 1 MICROSECOND)
       ELSE TIMESTAMP '9999-12-31 23:59:59 UTC'
  END,
  (seq.seq_num = 1),
  src.wawi_item_variant_nat_key_nr,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  '${LOAD_ID}',
  'WAWI_HQ'
FROM (
  SELECT
    max_sid + ROW_NUMBER() OVER (ORDER BY y.wawi_item_variant_nat_key_nr) AS wawi_item_variant_sid,
    y.gueltig_ab,
    y.wawi_item_variant_nat_key_nr,
    y.first_instance_fg,
    y.dummy_sid_reuse_fg
  FROM wawi_item_new_upd_wawi_item_variant_keys AS y
  CROSS JOIN (
    SELECT COALESCE(MAX(wawi_item_variant_sid), 0) AS max_sid
    FROM ldl_data_production_meta.t_wawi_item_variant_key
  ) AS z
) AS src
CROSS JOIN UNNEST([0,1]) AS seq(seq_num)
WHERE src.dummy_sid_reuse_fg = FALSE;

COMMIT;



CREATE OR REPLACE TEMP TABLE t_wawi_precore_item_temp AS
(
SELECT
  CASE WHEN a.wawi_instanz_kzl = 'CS' THEN 'ES' ELSE left(a.wawi_instanz_kzl,2) END AS country,
  SAFE_CAST(artnrvier AS INT64) AS itemnr,
  a.*,
  min_gueltig_ab
FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel AS a
JOIN wawi_items_with_deletion_range b
  ON left(a.wawi_instanz_kzl,2) = left(b.wawi_instanz_kzl,2)
 AND SAFE_CAST(artnrvier AS INT64) = b.orig_item_nr
 AND b.wawi_item_deleted_dt = DATE '9999-12-31'     --filter to pick only the correct ES/CS items
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY country, itemnr
    ORDER BY artikelnr ASC, extraction_tmsp DESC
) = 1       --pick the latest data. The sorting by artikelnr is for the code to always pick the same item variant
);

INSERT INTO ldl_data_production_${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
  wawi_item_nat_key_nr,
  wawi_item_key_type_cd,
  country_org_nat_key,
  country_org_key_type_cd,
  country_org_cd,
  wawi_item_nr,
  wawi_item_name,
  wawi_item_descr,
  wawi_item_creation_dt,
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
  country || '|' || ltrim(artnrvier,'0') AS wawi_item_nat_key_nr, --
  'WAWI' AS wawi_item_key_type_cd, --this is OK probably
  country AS country_org_nat_key,
  'COUNTRY' AS country_org_key_type_cd,
  country AS country_org_cd,
  ltrim(artnrvier,'0') AS wawi_item_nr,
  trim(coalesce(deutschtext,bez_lang,'Unbekannt')) AS wawi_item_name,
  trim(bez_lang) AS wawi_item_descr,
  min_gueltig_ab AS wawi_item_creation_dt,
  'WAWI' AS source_system,
  art.extraction_tmsp AS extraction_dt,
  art.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM t_wawi_precore_item_temp AS art
;
