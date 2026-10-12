CREATE OR REPLACE TEMPORARY TABLE wawi_items_with_deletion_range AS
WITH wawi_items_with_deleted_dt AS (
  SELECT DISTINCT
    t_wawi_precore_t920_delitems.ctrcode, /* Already deleted items */
    CASE
      WHEN length(t_wawi_precore_t920_delitems.c920_itemnr_short) = CAST('11' AS NUMERIC)
      THEN round(
        SAFE_CAST(substr(t_wawi_precore_t920_delitems.c920_itemnr_short, 1, 7) AS NUMERIC),
        0
      )
      ELSE coalesce(
        t_wawi_precore_t920_delitems.c920_itemnr_short,
        round(
          SAFE_CAST(LTRIM(LTRIM(t_wawi_precore_t920_delitems.c920_itemnr_short, '0'), ' ') AS NUMERIC),
          0
        )
      )
    END AS orig_item_nr, /* ? */
    CAST(t_wawi_precore_t920_delitems.c920_moddate AS DATE) AS deleted_dt,
    NULL AS min_gueltig_ab
  FROM etl.t_wawi_precore_t920_delitems
  WHERE
    NOT coalesce(
      t_wawi_precore_t920_delitems.c920_itemnr_short,
      round(
        SAFE_CAST(LTRIM(LTRIM(t_wawi_precore_t920_delitems.c920_itemnr_short, '0'), ' ') AS NUMERIC),
        0
      )
    ) /* ? */ IS NULL
  UNION ALL
  SELECT
    t_wawi_precore_artikel.ctrcode, /* Currently active items */
    CAST(t_wawi_precore_artikel.artnrvier AS NUMERIC) AS orig_item_nr,
    CAST('9999-12-31' AS DATE) AS deleted_dt,
    MIN(t_wawi_precore_artikel.gueltig_ab) AS min_gueltig_ab
  FROM etl.t_wawi_precore_artikel
  GROUP BY
    1,
    2
), wawi_items_with_deleted_dt_cses AS (
  SELECT
    wawi_items_with_deleted_dt.*
  FROM wawi_items_with_deleted_dt
), wawi_items_with_range AS (
  SELECT
    wi.ctrcode, /* QUALIFY Max(ctrcode) OVER (PARTITION BY CASE WHEN ctrcode = 'CS' THEN 'ES' ELSE ctrcode END
                                                    , orig_item_nr)
                      = ctrcode */
    wi.orig_item_nr,
    coalesce(
      DATE_ADD(lag(wi.deleted_dt, 1) OVER (
        PARTITION BY wi.ctrcode, wi.orig_item_nr
        ORDER BY IF(wi.deleted_dt IS NULL, 0, 1) DESC, wi.deleted_dt
      ), INTERVAL '1' DAY),
      CAST('1900-01-01' AS DATE)
    ) AS wawi_item_prev_deleted_dt,
    wi.deleted_dt AS wawi_item_deleted_dt,
    wi.min_gueltig_ab
  FROM wawi_items_with_deleted_dt_cses AS wi
)
SELECT
  del.*,
  CASE WHEN del.ctrcode = 'CS' THEN 'ES' ELSE del.ctrcode END AS country,
  prev_keys.wawi_item_nat_key_nr,
  prev_keys.dwh_valid_from_tmsp AS prev_dwh_valid_from_tmsp
FROM wawi_items_with_range AS del
LEFT OUTER JOIN meta.t_wawi_item_key AS prev_keys /* check if key already exists */
  ON CASE WHEN del.ctrcode = 'CS' THEN 'ES' ELSE del.ctrcode END = bqutil.fn.cw_split_part_delimstr_idx(prev_keys.wawi_item_nat_key_nr, '|', 1)
  AND del.orig_item_nr = CAST(bqutil.fn.cw_split_part_delimstr_idx(prev_keys.wawi_item_nat_key_nr, '|', 2) AS NUMERIC)
  AND prev_keys.dwh_valid_fg = 1
QUALIFY
  row_number() OVER (
    PARTITION BY country, del.orig_item_nr, del.wawi_item_deleted_dt
    ORDER BY IF(del.ctrcode IS NULL, 0, 1), del.ctrcode DESC
  ) = 1;

/* If an item is existing in previous Meta table with valid_from less than last deleted date, and comes in new artikel source with gueltig_ab greater than last deleted dt, generate new sid */
CREATE OR REPLACE TEMPORARY TABLE wawi_item_new_upd_wawi_item_keys AS
SELECT
  wawi_items_with_deletion_range.country,
  wawi_items_with_deletion_range.orig_item_nr,
  wawi_items_with_deletion_range.min_gueltig_ab
FROM wawi_items_with_deletion_range
WHERE
  wawi_items_with_deletion_range.wawi_item_deleted_dt = CAST('9999-12-31' AS DATE)
  AND (
    wawi_items_with_deletion_range.wawi_item_nat_key_nr IS NULL /* completely new items */
    OR wawi_items_with_deletion_range.wawi_item_prev_deleted_dt <> CAST('1900-01-01' AS DATE) /* the last deletion date is not null */
    AND wawi_items_with_deletion_range.min_gueltig_ab > wawi_items_with_deletion_range.wawi_item_prev_deleted_dt /* gueltig_ab bigger than last deletion date */
    AND wawi_items_with_deletion_range.wawi_item_prev_deleted_dt >= wawi_items_with_deletion_range.prev_dwh_valid_from_tmsp
  );

/* the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT dwh_valid_from (gueltig_ab) */ /* If an item variant is existing in previous Meta table with valid_from less than last deleted date, and comes in new artikel source with gueltig_ab greater than last deleted dt, generate new sid */
CREATE OR REPLACE TEMPORARY TABLE t_wawi_precore_item_variant_temp AS
SELECT
  country_es_cs AS country_es_cs,
  CAST(artnrvier AS NUMERIC) AS itemnr,
  src_case_size AS src_case_size,
  CONCAT(
    country_es_cs,
    '|',
    CAST(CAST(artnrvier AS NUMERIC) AS STRING),
    '|',
    CAST(src_case_size AS STRING)
  ) AS wawi_item_variant_nat_key_nr,
  a.*,
  b.wawi_item_prev_deleted_dt,
  b.wawi_item_deleted_dt
FROM etl.t_wawi_precore_artikel AS a
INNER JOIN wawi_items_with_deletion_range AS b
  ON CASE WHEN a.ctrcode = 'CS' THEN 'ES' ELSE a.ctrcode END = b.country
  AND CAST(artnrvier AS NUMERIC) = b.orig_item_nr
  AND b.wawi_item_deleted_dt = CAST('9999-12-31' AS DATE) /* filter to pick only the correct ES/CS items */
CROSS JOIN UNNEST([round(SAFE_CAST(right(artikelnr, 4) AS NUMERIC), 0)]) AS src_case_size
CROSS JOIN UNNEST([CASE WHEN a.ctrcode = 'CS' THEN 'ES' ELSE a.ctrcode END]) AS country_es_cs
QUALIFY
  row_number() OVER (
    PARTITION BY CONCAT(country_es_cs, '|', CAST(itemnr AS STRING), '|', CAST(src_case_size AS STRING))
    ORDER BY IF(a.ctrcode IS NULL, 0, 1), a.ctrcode DESC, IF(artikelnr IS NULL, 0, 1) DESC, artikelnr, IF(extraction_tmsp IS NULL, 0, 1), extraction_tmsp DESC
  ) = 1;

/* pick the latest data. Chose ES variant over CS variant. The sorting by artikelnr is for the code to always pick the same item variant */
CREATE OR REPLACE TEMPORARY TABLE wawi_item_new_upd_wawi_item_variant_keys AS
SELECT
  a.wawi_item_variant_nat_key_nr,
  a.gueltig_ab
FROM t_wawi_precore_item_variant_temp AS a
LEFT OUTER JOIN meta.t_wawi_item_variant_key AS prev_keys
  ON a.country_es_cs = bqutil.fn.cw_split_part_delimstr_idx(prev_keys.wawi_item_variant_nat_key_nr, '|', 1)
  AND a.itemnr = CAST(bqutil.fn.cw_split_part_delimstr_idx(prev_keys.wawi_item_variant_nat_key_nr, '|', 2) AS NUMERIC)
  AND a.src_case_size = CAST(bqutil.fn.cw_split_part_delimstr_idx(prev_keys.wawi_item_variant_nat_key_nr, '|', 3) AS NUMERIC)
  AND prev_keys.dwh_valid_fg = 1
WHERE
  a.wawi_item_deleted_dt = CAST('9999-12-31' AS DATE)
  AND (
    prev_keys.wawi_item_variant_nat_key_nr IS NULL /* completely new item variants */
    OR a.wawi_item_prev_deleted_dt <> CAST('1900-01-01' AS DATE) /* the last deletion date is not null */
    AND a.gueltig_ab > a.wawi_item_prev_deleted_dt /* gueltig_ab bigger than last deletion date */
    AND a.wawi_item_prev_deleted_dt >= prev_keys.dwh_valid_from_tmsp
  );

BEGIN TRANSACTION /* the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT dwh_valid_from (gueltig_ab) */ /* the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT dwh_valid_from (gueltig_ab) */;

DELETE FROM meta.t_wawi_item_key AS x
WHERE
  1 = 2;

/* lock the whole table */
DELETE FROM meta.t_wawi_item_variant_key AS x
WHERE
  1 = 2;

/* lock the whole table */
UPDATE meta.t_wawi_item_key AS x SET dwh_valid_fg = FALSE, dwh_valid_to_tmsp = DATE_SUB(y.min_gueltig_ab, INTERVAL '1' NANOSECOND), dwh_updated_tmsp = current_timestamp(), dwh_load_id = ${load_id}, dwh_node_cd = 'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_keys AS y /* should produce 0, the keys should be already generated by xx_upsert_hist_wawi_precore_artikel_2_wawi_item.pset */
WHERE
  CONCAT(y.country, '|', CAST(y.orig_item_nr AS STRING)) = x.wawi_item_nat_key_nr
  AND dwh_valid_fg = TRUE;

INSERT INTO meta.t_wawi_item_key (
  wawi_item_nat_key_nr,
  dwh_valid_fg,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd,
  wawi_item_sid
)
SELECT
  z.max_sid + row_number() OVER (
    ORDER BY IF(CONCAT(y.country, '|', CAST(y.orig_item_nr AS STRING)) IS NULL, 0, 1) DESC, CONCAT(y.country, '|', CAST(y.orig_item_nr AS STRING))
  ) AS wawi_item_sid,
  'WAWI',
  y.min_gueltig_ab,
  '9999-12-31 23:59:59.999999999',
  TRUE,
  CONCAT(y.country, '|', CAST(y.orig_item_nr AS STRING)),
  current_timestamp(),
  current_timestamp(),
  ${load_id},
  'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_keys AS y
CROSS JOIN (
  SELECT
    MAX(t_wawi_item_key.wawi_item_sid) AS max_sid
  FROM meta.t_wawi_item_key
) AS z;

UPDATE meta.t_wawi_item_variant_key AS x SET dwh_valid_fg = FALSE, dwh_valid_to_tmsp = DATETIME_SUB(y.gueltig_ab, INTERVAL '1' NANOSECOND), dwh_updated_tmsp = current_timestamp(), dwh_load_id = ${load_id}, dwh_node_cd = 'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_variant_keys AS y
WHERE
  y.wawi_item_variant_nat_key_nr = x.wawi_item_variant_nat_key_nr
  AND dwh_valid_fg = TRUE;

INSERT INTO meta.t_wawi_item_variant_key (
  wawi_item_variant_nat_key_nr,
  dwh_valid_fg,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd,
  wawi_item_variant_sid
)
SELECT
  z.max_sid + row_number() OVER (
    ORDER BY IF(y.wawi_item_variant_nat_key_nr IS NULL, 0, 1) DESC, y.wawi_item_variant_nat_key_nr
  ) AS wawi_item_variant_sid,
  'WAWI',
  y.gueltig_ab,
  '9999-12-31 23:59:59.999999999',
  TRUE,
  y.wawi_item_variant_nat_key_nr,
  current_timestamp(),
  current_timestamp(),
  ${load_id},
  'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_variant_keys AS y
CROSS JOIN (
  SELECT
    MAX(t_wawi_item_variant_key.wawi_item_variant_sid) AS max_sid
  FROM meta.t_wawi_item_variant_key
) AS z;

COMMIT TRANSACTION;

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
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
  CONCAT(art.country_es_cs, '|', LTRIM(artnrvier, '0')) AS wawi_item_nat_key_nr, /* FRAMEWORK AND TECHNICAL COLUMNS */
  'WAWI' AS wawi_item_key_type_cd,
  'WAWI' AS wawi_item_variant_key_type_cd,
  CONCAT(art.country_es_cs, '|', itemnr, '|', src_case_size) AS wawi_item_variant_nat_key_nr,
  art.country_es_cs AS country_org_nat_key,
  'COUNTRY' AS country_org_key_type_cd,
  art.country_es_cs AS country_org_cd,
  art.artikelnr AS wawi_item_variant_nr,
  TRIM(coalesce(deutschtext, bez_lang, 'Unbekannt'), ' ') AS wawi_item_variant_name,
  TRIM(art.bez_lang, ' ') AS wawi_item_variant_descr,
  gueltig_ab AS wawi_item_variant_creation_dt,
  right(art.artikelnr, 4) AS case_size_cnt,
  coalesce(itmo.weight_based_fg, 0 <> 0) AS weight_based_fg, /* ? */
  'WAWI' AS source_system, /* ------------------------------ */
  art.extraction_tmsp AS extraction_dt,
  art.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM ${temp_db}.t_wawi_precore_item_variant_temp AS art
LEFT OUTER JOIN (
  SELECT
    t_wawi_precore_artikelbestell.ctrcode,
    round(
      CAST(substr(
        t_wawi_precore_artikelbestell.artikelnr,
        1,
        CAST(length(t_wawi_precore_artikelbestell.artikelnr) - 4 AS INT64)
      ) AS NUMERIC),
      0
    ) AS artikelnr,
    logical_or(
      CASE
        WHEN t_wawi_precore_artikelbestell.gewichtsartikel = 1
        THEN TRUE
        ELSE t_wawi_precore_artikelbestell.gewichtsartikel
      END
    ) AS weight_based_fg
  FROM ${temp_db}.t_wawi_precore_artikelbestell
  GROUP BY
    1,
    round(
      CAST(substr(CAST(artikelnr AS STRING), 1, CAST(length(CAST(artikelnr AS STRING)) - 4 AS INT64)) AS NUMERIC),
      0
    )
) AS itmo
  ON art.ctrcode = itmo.ctrcode AND art.itemnr = itmo.artikelnr;

/* For item numbers existing in both CS and ES, use only the part from ES -- removed */;