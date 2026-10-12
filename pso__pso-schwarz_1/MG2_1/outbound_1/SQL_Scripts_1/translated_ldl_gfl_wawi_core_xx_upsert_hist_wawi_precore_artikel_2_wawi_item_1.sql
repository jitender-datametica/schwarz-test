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
  FROM etl.t_wawi_precore_t920_delitems_1
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
  FROM etl.t_wawi_precore_artikel_1
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
  CASE WHEN del.ctrcode = 'CS' THEN 'ES' ELSE del.ctrcode END AS country_1,
  prev_keys.wawi_item_nat_key_nr,
  prev_keys.dwh_valid_from_tmsp AS prev_dwh_valid_from_tmsp
FROM wawi_items_with_range AS del
LEFT OUTER JOIN meta.t_wawi_item_key_1 AS prev_keys /* check if key already exists */
  ON CASE WHEN del.ctrcode = 'CS' THEN 'ES' ELSE del.ctrcode END = bqutil.fn.cw_split_part_delimstr_idx(prev_keys.wawi_item_nat_key_nr, '|', 1)
  AND del.orig_item_nr = CAST(bqutil.fn.cw_split_part_delimstr_idx(prev_keys.wawi_item_nat_key_nr, '|', 2) AS NUMERIC)
  AND prev_keys.dwh_valid_fg = 1
QUALIFY
  row_number() OVER (
    PARTITION BY country_1, del.orig_item_nr, del.wawi_item_deleted_dt
    ORDER BY IF(del.ctrcode IS NULL, 0, 1), del.ctrcode DESC
  ) = 1;

/* If an item_1 is existing in previous Meta table with valid_from less than last deleted date, and comes in new artikel_1 source with gueltig_ab greater than last deleted dt, generate new sid */
CREATE OR REPLACE TEMPORARY TABLE wawi_item_new_upd_wawi_item_keys AS
SELECT
  wawi_items_with_deletion_range.country_1,
  wawi_items_with_deletion_range.orig_item_nr,
  wawi_items_with_deletion_range.min_gueltig_ab,
  wawi_items_with_deletion_range.wawi_item_nat_key_nr IS NULL /* First instance of a NK will get additionally the 1900-01-01 record */ AS first_instance_fg
FROM wawi_items_with_deletion_range
WHERE
  wawi_items_with_deletion_range.wawi_item_deleted_dt = CAST('9999-12-31' AS DATE)
  AND (
    wawi_items_with_deletion_range.wawi_item_nat_key_nr IS NULL /* completely new items */
    OR wawi_items_with_deletion_range.wawi_item_prev_deleted_dt <> CAST('1900-01-01' AS DATE) /* the last deletion date is not null */
    AND wawi_items_with_deletion_range.min_gueltig_ab > wawi_items_with_deletion_range.wawi_item_prev_deleted_dt /* gueltig_ab bigger than last deletion date */
    AND wawi_items_with_deletion_range.wawi_item_prev_deleted_dt >= wawi_items_with_deletion_range.prev_dwh_valid_from_tmsp
  );

/* the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT_1 dwh_valid_from (gueltig_ab) */ /* If an item_1 has already arrived from master data and its SID was generated outside of WAWI-item_1 transformation, */ /* we continue to use already generated SID */
CREATE OR REPLACE TEMPORARY TABLE wawi_item_dummy_key_upd AS
SELECT
  wik.wawi_item_sid,
  wik.wawi_item_key_type_cd,
  CASE
    WHEN seq.seq_num = 0
    THEN CAST('1900-01-01 00:00:00.000000000' AS TIMESTAMP)
    ELSE wi.min_gueltig_ab
  END AS dwh_valid_from_tmsp,
  CASE
    WHEN seq.seq_num = 0
    THEN ERROR_UNIMPLEMENTED(ns, -1, wi.min_gueltig_ab)
    ELSE CAST('9999-12-31 23:59:59.999999999' AS TIMESTAMP)
  END AS dwh_valid_to_tmsp,
  seq.seq_num = 1 AS dwh_valid_fg,
  wik.wawi_item_nat_key_nr
FROM wawi_items_with_deletion_range AS wi
INNER JOIN meta.t_wawi_item_key_1 AS wik
  ON CONCAT(wi.country_1, '|', CAST(wi.orig_item_nr AS STRING)) = wik.wawi_item_nat_key_nr
  AND wik.wawi_item_key_type_cd = 'WAWI'
  AND wik.dwh_valid_fg = TRUE
INNER JOIN core_rel.t_wawi_item_1 AS i
  ON wik.wawi_item_sid = i.wawi_item_sid
  AND i.dwh_valid_fg = TRUE
  AND i.wawi_item_creation_dt = CAST('1900-01-01' AS DATE)
CROSS JOIN (
  SELECT
    a.seq_num
  FROM (
    SELECT
      0 AS seq_num
    UNION ALL
    SELECT
      1
  ) AS a
) AS seq;

/* If an item_1 variant is existing in previous Meta table with valid_from less than last deleted date, and comes in new artikel_1 source with gueltig_ab greater than last deleted dt, generate new sid */
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
FROM etl.t_wawi_precore_artikel_1 AS a
INNER JOIN wawi_items_with_deletion_range AS b
  ON CASE WHEN a.ctrcode = 'CS' THEN 'ES' ELSE a.ctrcode END = b.country_1
  AND CAST(artnrvier AS NUMERIC) = b.orig_item_nr
  AND b.wawi_item_deleted_dt = CAST('9999-12-31' AS DATE) /* filter to pick only the correct ES/CS items */
CROSS JOIN UNNEST([round(SAFE_CAST(right(artikelnr, 4) AS NUMERIC), 0)]) AS src_case_size
CROSS JOIN UNNEST([CASE WHEN a.ctrcode = 'CS' THEN 'ES' ELSE a.ctrcode END]) AS country_es_cs
QUALIFY
  row_number() OVER (
    PARTITION BY CONCAT(country_es_cs, '|', CAST(itemnr AS STRING), '|', CAST(src_case_size AS STRING))
    ORDER BY IF(a.ctrcode IS NULL, 0, 1), a.ctrcode DESC, IF(artikelnr IS NULL, 0, 1) DESC, artikelnr, IF(extraction_tmsp IS NULL, 0, 1), extraction_tmsp DESC
  ) = 1;

/* pick the latest data. Chose ES variant over CS variant. The sorting by artikelnr is for the code to always pick the same item_1 variant */
CREATE OR REPLACE TEMPORARY TABLE wawi_item_new_upd_wawi_item_variant_keys AS
SELECT
  a.wawi_item_variant_nat_key_nr,
  a.gueltig_ab,
  prev_keys.wawi_item_variant_nat_key_nr /* First instance of a NK will get additionally the 1900-01-01 record */ IS NULL AS first_instance_fg,
  NOT dvk.wawi_item_variant_sid /* Variant with lowest case size will use the dummy_1 SID if it exists */ IS NULL
  AND row_number() OVER (
    PARTITION BY a.country_es_cs, a.itemnr
    ORDER BY IF(a.src_case_size IS NULL, 0, 1) DESC, a.src_case_size
  ) = 1 AS dummy_sid_reuse_fg,
  CASE
    WHEN row_number() OVER (
      PARTITION BY a.country_es_cs, a.itemnr
      ORDER BY IF(a.src_case_size IS NULL, 0, 1) DESC, a.src_case_size
    ) = 1
    THEN dvk.wawi_item_variant_sid
    ELSE NULL
  END AS wawi_item_variant_sid
FROM t_wawi_precore_item_variant_temp AS a
LEFT OUTER JOIN meta.t_wawi_item_variant_key_1 AS prev_keys
  ON a.country_es_cs = bqutil.fn.cw_split_part_delimstr_idx(prev_keys.wawi_item_variant_nat_key_nr, '|', 1)
  AND a.itemnr = CAST(bqutil.fn.cw_split_part_delimstr_idx(prev_keys.wawi_item_variant_nat_key_nr, '|', 2) AS NUMERIC)
  AND a.src_case_size = CAST(bqutil.fn.cw_split_part_delimstr_idx(prev_keys.wawi_item_variant_nat_key_nr, '|', 3) AS NUMERIC)
  AND prev_keys.dwh_valid_fg = 1
LEFT OUTER JOIN wawi_item_dummy_key_upd AS dik
  ON CONCAT(a.country_es_cs, '|', CAST(a.itemnr AS STRING)) = dik.wawi_item_nat_key_nr
  AND dik.dwh_valid_fg = TRUE
LEFT OUTER JOIN meta.t_wawi_item_variant_key_1 AS dvk
  ON CONCAT(dik.wawi_item_nat_key_nr, '|0') = dvk.wawi_item_variant_nat_key_nr
  AND dvk.dwh_valid_fg = TRUE
WHERE
  a.wawi_item_deleted_dt = CAST('9999-12-31' AS DATE)
  AND (
    prev_keys.wawi_item_variant_nat_key_nr IS NULL /* completely new item_1 variants */
    OR a.wawi_item_prev_deleted_dt <> CAST('1900-01-01' AS DATE) /* the last deletion date is not null */
    AND a.gueltig_ab > a.wawi_item_prev_deleted_dt /* gueltig_ab bigger than last deletion date */
    AND a.wawi_item_prev_deleted_dt >= prev_keys.dwh_valid_from_tmsp
  );

BEGIN TRANSACTION /* the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT_1 dwh_valid_from (gueltig_ab) */ /* the last deletion date is bigger than META.T_WAWI_ITEM_VARIANT_1 dwh_valid_from (gueltig_ab) */;

DELETE FROM meta.t_wawi_item_key_1 AS x
WHERE
  1 = 2;

/* lock the whole table */
DELETE FROM meta.t_wawi_item_variant_key_1 AS x
WHERE
  1 = 2;

MERGE INTO meta.t_wawi_item_key_1 AS tgt
USING wawi_item_dummy_key_upd AS src
ON tgt.wawi_item_sid = src.wawi_item_sid
AND tgt.dwh_valid_from_tmsp = src.dwh_valid_from_tmsp
WHEN MATCHED THEN UPDATE SET
  dwh_valid_to_tmsp = src.dwh_valid_to_tmsp,
  dwh_valid_fg = src.dwh_valid_fg,
  dwh_updated_tmsp = current_timestamp(),
  dwh_load_id = ${load_id}
WHEN NOT MATCHED THEN INSERT (
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
) VALUES (
  src.wawi_item_sid,
  src.wawi_item_key_type_cd,
  src.dwh_valid_from_tmsp,
  src.dwh_valid_to_tmsp,
  src.dwh_valid_fg,
  src.wawi_item_nat_key_nr,
  current_timestamp(),
  current_timestamp(),
  src.${load_id},
  'WAWI_HQ'
) /* lock the whole table */ /* Keep using the dummy_1 generated SID in case when the NK (country_1, itemnr) is delivered in item_1 data */;

UPDATE meta.t_wawi_item_key_1 AS x SET dwh_valid_fg = FALSE, dwh_valid_to_tmsp = DATE_SUB(y.min_gueltig_ab, INTERVAL '1' NANOSECOND), dwh_updated_tmsp = current_timestamp(), dwh_load_id = ${load_id}, dwh_node_cd = 'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_keys AS y /* should produce 0, the keys should be already generated by xx_upsert_hist_wawi_precore_artikel_2_wawi_item.pset */
WHERE
  CONCAT(y.country_1, '|', CAST(y.orig_item_nr AS STRING)) = x.wawi_item_nat_key_nr
  AND dwh_valid_fg = TRUE;

INSERT INTO meta.t_wawi_item_key_1 (
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
  src.wawi_item_sid,
  'WAWI',
  CASE
    WHEN seq.seq_num = 0
    THEN CAST('1900-01-01 00:00:00.000000000' AS TIMESTAMP)
    ELSE src.min_gueltig_ab
  END,
  CASE
    WHEN seq.seq_num = 0
    THEN ERROR_UNIMPLEMENTED(ns, -1, src.min_gueltig_ab)
    ELSE CAST('9999-12-31 23:59:59.999999999' AS TIMESTAMP)
  END,
  seq.seq_num = 1,
  CONCAT(src.country_1, '|', CAST(src.orig_item_nr AS STRING)),
  current_timestamp(),
  current_timestamp(),
  ${load_id},
  'WAWI_HQ'
/* First generate new SIDs */
FROM (
  SELECT
    z.max_sid + row_number() OVER (
      ORDER BY IF(CONCAT(y.country_1, '|', CAST(y.orig_item_nr AS STRING)) IS NULL, 0, 1) DESC, CONCAT(y.country_1, '|', CAST(y.orig_item_nr AS STRING))
    ) AS wawi_item_sid,
    y.country_1,
    y.min_gueltig_ab,
    y.orig_item_nr,
    y.first_instance_fg
  FROM wawi_item_new_upd_wawi_item_keys AS y
  CROSS JOIN (
    SELECT
      MAX(t_wawi_item_key.wawi_item_sid) AS max_sid
    FROM meta.t_wawi_item_key_1
  ) AS z
) AS src
/* Then join to add the initial line starting from 1900 if needed */
INNER JOIN (
  SELECT
    a.seq_num
  FROM (
    SELECT
      0 AS seq_num
    UNION ALL
    SELECT
      1
  ) AS a
) AS seq
  ON src.first_instance_fg = TRUE OR seq.seq_num = 1;

/* Use the SID given to the dummy_1 variant for the variant with lowest case size */ /* when item_1 is delivered */
UPDATE meta.t_wawi_item_variant_key_1 AS tgt SET dwh_valid_fg = FALSE, dwh_valid_to_tmsp = DATETIME_SUB(src.gueltig_ab, INTERVAL '1' NANOSECOND), wawi_item_variant_nat_key_nr = src.wawi_item_variant_nat_key_nr, dwh_updated_tmsp = current_timestamp(), dwh_load_id = ${load_id}
FROM wawi_item_new_upd_wawi_item_variant_keys AS src
WHERE
  tgt.wawi_item_variant_sid = src.wawi_item_variant_sid
  AND src.dummy_sid_reuse_fg = TRUE;

INSERT INTO meta.t_wawi_item_variant_key_1 (
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
  wawi_item_new_upd_wawi_item_variant_keys.wawi_item_variant_sid,
  'WAWI',
  wawi_item_new_upd_wawi_item_variant_keys.gueltig_ab,
  '9999-12-31 23:59:59.999999999',
  TRUE,
  wawi_item_new_upd_wawi_item_variant_keys.wawi_item_variant_nat_key_nr,
  current_timestamp(),
  current_timestamp(),
  wawi_item_new_upd_wawi_item_variant_keys.${load_id},
  'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_variant_keys
WHERE
  wawi_item_new_upd_wawi_item_variant_keys.dummy_sid_reuse_fg = TRUE;

UPDATE meta.t_wawi_item_variant_key_1 AS x SET dwh_valid_fg = FALSE, dwh_valid_to_tmsp = DATETIME_SUB(y.gueltig_ab, INTERVAL '1' NANOSECOND), dwh_updated_tmsp = current_timestamp(), dwh_load_id = ${load_id}, dwh_node_cd = 'WAWI_HQ'
FROM wawi_item_new_upd_wawi_item_variant_keys AS y
WHERE
  y.wawi_item_variant_nat_key_nr = x.wawi_item_variant_nat_key_nr
  AND x.dwh_valid_fg = TRUE
  AND y.dummy_sid_reuse_fg = FALSE;

INSERT INTO meta.t_wawi_item_variant_key_1 (
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
  CASE
    WHEN seq.seq_num = 0
    THEN CAST('1900-01-01 00:00:00.000000000' AS TIMESTAMP)
    ELSE src.gueltig_ab
  END,
  CASE
    WHEN seq.seq_num = 0
    THEN ERROR_UNIMPLEMENTED(ns, -1, src.gueltig_ab)
    ELSE CAST('9999-12-31 23:59:59.999999999' AS TIMESTAMP)
  END,
  seq.seq_num = 1,
  src.wawi_item_variant_nat_key_nr,
  current_timestamp(),
  current_timestamp(),
  ${load_id},
  'WAWI_HQ'
FROM (
  SELECT
    z.max_sid + row_number() OVER (
      ORDER BY IF(y.wawi_item_variant_nat_key_nr IS NULL, 0, 1) DESC, y.wawi_item_variant_nat_key_nr
    ) AS wawi_item_variant_sid,
    y.gueltig_ab,
    y.wawi_item_variant_nat_key_nr,
    y.first_instance_fg,
    y.dummy_sid_reuse_fg
  FROM wawi_item_new_upd_wawi_item_variant_keys AS y
  CROSS JOIN (
    SELECT
      MAX(t_wawi_item_variant_key.wawi_item_variant_sid) AS max_sid
    FROM meta.t_wawi_item_variant_key_1
  ) AS z
) AS src
INNER JOIN (
  SELECT
    a.seq_num
  FROM (
    SELECT
      0 AS seq_num
    UNION ALL
    SELECT
      1
  ) AS a
) AS seq
  ON src.first_instance_fg = TRUE OR seq.seq_num = 1
WHERE
  src.dummy_sid_reuse_fg = FALSE;

COMMIT TRANSACTION;

CREATE OR REPLACE TEMPORARY TABLE t_wawi_precore_item_temp AS
SELECT
  CASE WHEN a.ctrcode = 'CS' THEN 'ES' ELSE a.ctrcode END AS country_1,
  CAST(artnrvier AS NUMERIC) AS itemnr,
  a.*,
  b.min_gueltig_ab
FROM etl.t_wawi_precore_artikel_1 AS a
INNER JOIN wawi_items_with_deletion_range AS b
  ON a.ctrcode = b.ctrcode
  AND CAST(artnrvier AS NUMERIC) = b.orig_item_nr
  AND b.wawi_item_deleted_dt = CAST('9999-12-31' AS DATE) /* filter to pick only the correct ES/CS items */
QUALIFY
  row_number() OVER (
    PARTITION BY b.country_1, itemnr
    ORDER BY IF(artikelnr IS NULL, 0, 1) DESC, artikelnr, IF(extraction_tmsp IS NULL, 0, 1), extraction_tmsp DESC
  ) = 1;

/* pick the latest data. The sorting by artikelnr is for the code to always pick the same item_1 variant */
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
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
  CONCAT(art.country_1, '|', LTRIM(art.artnrvier, '0')) AS wawi_item_nat_key_nr,
  'WAWI' AS wawi_item_key_type_cd, /* this is OK probably */
  art.country_1 AS country_org_nat_key,
  'COUNTRY_1' AS country_org_key_type_cd,
  art.country_1 AS country_org_cd,
  LTRIM(art.artnrvier, '0') AS wawi_item_nr,
  TRIM(coalesce(art.deutschtext, art.bez_lang, 'Unbekannt'), ' ') AS wawi_item_name,
  TRIM(art.bez_lang, ' ') AS wawi_item_descr,
  art.min_gueltig_ab AS wawi_item_creation_dt,
  'WAWI' AS source_system,
  art.extraction_tmsp AS extraction_dt,
  art.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM t_wawi_precore_item_temp AS art_1;

/* For item_1 numbers existing in both CS and ES, use only the part from ES -- removed */;