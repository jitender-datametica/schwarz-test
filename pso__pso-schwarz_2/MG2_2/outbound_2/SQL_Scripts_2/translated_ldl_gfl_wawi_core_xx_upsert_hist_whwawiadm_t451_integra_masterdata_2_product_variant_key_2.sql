INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_variant_sid,
  prod_variant_key_type_cd,
  prod_variant_nat_key_nr,
  source_system,
  dwh_mapping_tmsp,
  extraction_dt,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
WITH t451 AS (
  SELECT
    * /* FV LOG */
  FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t451_integra_masterdata_2 AS src
  WHERE
    src.delete_fg IS NULL
    AND NOT CAST(src.c451_itemnr AS NUMERIC) IN (
      SELECT
        CAST(itemno AS NUMERIC)
      FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_2
      WHERE
        delete_fg IS NULL
        AND NOT itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
    )
  QUALIFY
    row_number() OVER (
      PARTITION BY left(src.wawi_instanz_kzl, 2), src.c451_itemnr, src.c451_subitemnr
      ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
    ) = 1
), t026 AS (
  SELECT
    *
  FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_2
  WHERE
    t026_wawi_item.delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY t026_wawi_item.itemno
      ORDER BY IF(t026_wawi_item.seqid IS NULL, 0, 1), t026_wawi_item.seqid DESC
    ) = 1
)
SELECT DISTINCT
  vkey.prod_variant_sid AS prod_variant_sid,
  'LOG' AS prod_variant_key_type_cd,
  upper(CONCAT(left(src.wawi_instanz_kzl, 2), '|', CAST(src.wawi_itemnr AS STRING))) AS prod_variant_nat_key_nr,
  'FV' AS source_system,
  current_timestamp() AS dwh_mapping_tmsp,
  current_timestamp() AS extraction_dt,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_WH' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    left(wint.wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
    wint.wawi_itemnr,
    wint.wawi_casesize,
    CASE
      WHEN itm.cnt = 1
      THEN CONCAT(CAST(itm.itemnr AS STRING), '|', CAST(itm.subitemnr AS STRING))
      ELSE substr(CAST(itm.itemnr AS STRING), 1, 16777216)
    END AS pvar_nat_key,
    CASE WHEN itm.cnt = 1 THEN 'FV_LOG' ELSE 'FV_LOG_UNK' END AS pvar_key_type_cd
  FROM (
    SELECT
      subselect.itemnr,
      CAST(count(*) AS NUMERIC) AS cnt,
      MAX(subselect.c451_subitemnr) AS subitemnr
    FROM (
      SELECT
        CAST(t451.c451_itemnr AS NUMERIC) AS itemnr,
        t451.c451_subitemnr
      FROM t451
      GROUP BY
        1,
        2
    ) AS subselect
    GROUP BY
      1
    UNION ALL
    SELECT
      t026.itemno AS itemnr,
      0 AS cnt,
      0 AS subitemnr
    FROM t026
    WHERE
      t026.itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
      AND NOT t026.itemno IN (
        SELECT DISTINCT
          CAST(c451_itemnr AS NUMERIC) AS itemnr
        FROM t451
      )
  ) AS itm
  INNER JOIN (
    SELECT
      left(t215_int_itemnr.wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
      t215_int_itemnr.c215_int_itemnr AS int_itemnr,
      round(
        SAFE_CAST(substr(
          t215_int_itemnr.c215_itemnr,
          1,
          CAST(length(t215_int_itemnr.c215_itemnr) - 4 AS INT64)
        ) AS NUMERIC),
        0
      ) AS wawi_itemnr,
      round(SAFE_CAST(right(t215_int_itemnr.c215_itemnr, 4) AS NUMERIC), 0) AS wawi_casesize
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr_2
    WHERE
      t215_int_itemnr.delete_fg IS NULL
  ) AS wint
    ON itm.itemnr = wint.int_itemnr
  QUALIFY
    row_number() OVER (
      PARTITION BY wint.wawi_instanz_kzl, wint.wawi_itemnr
      ORDER BY wint.wawi_casesize DESC
    ) = 1
) AS src
INNER JOIN meta.t_product_variant_key_2 AS vkey
  ON vkey.prod_variant_nat_key_nr = substr(src.pvar_nat_key, 1, 200)
  AND vkey.dwh_valid_fg = TRUE
  AND vkey.prod_variant_key_type_cd = src.pvar_key_type_cd
UNION ALL
SELECT DISTINCT
  vkey.prod_variant_sid AS prod_variant_sid,
  'SLS_UNK' AS prod_variant_key_type_cd,
  CONCAT(left(src.wawi_instanz_kzl, 2), '|', CAST(src.itemnr AS STRING)) AS prod_variant_nat_key_nr,
  'FV' AS source_system,
  current_timestamp() AS dwh_mapping_tmsp,
  src.extraction_tmsp AS extraction_dt,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_WH' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    substr(CAST(itemnr.itemnr AS STRING), 1, 16777216) AS prod_nr,
    left(iit.wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
    iit.itemnr AS itemnr,
    iit.extraction_tmsp
  FROM (
    SELECT
      subselect.itemnr
    FROM (
      SELECT
        CAST(t451.c451_itemnr AS NUMERIC) AS itemnr,
        t451.c451_subitemnr
      FROM t451
      GROUP BY
        1,
        2
    ) AS subselect
    GROUP BY
      1
    HAVING
      count(*) > 1
    UNION ALL
    SELECT
      t026.itemno AS itemnr
    FROM t026
    WHERE
      t026.itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
      AND NOT t026.itemno IN (
        SELECT DISTINCT
          CAST(c451_itemnr AS NUMERIC) AS itemnr
        FROM t451
      )
  ) AS itemnr
  INNER JOIN (
    SELECT
      cw_win_ss.wawi_instanz_kzl,
      cw_win_ss.itemnr,
      cw_win_ss.c215_int_itemnr,
      cw_win_ss.extraction_tmsp,
      cw_win_ss.active_fg
    FROM (
      SELECT
        t215_int_itemnr.wawi_instanz_kzl,
        round(
          CAST(substr(
            t215_int_itemnr.c215_itemnr,
            1,
            CAST(length(t215_int_itemnr.c215_itemnr) - 4 AS INT64)
          ) AS NUMERIC),
          0
        ) AS itemnr,
        CAST(t215_int_itemnr.c215_int_itemnr AS NUMERIC) AS c215_int_itemnr,
        MIN(t215_int_itemnr.extraction_tmsp) AS extraction_tmsp,
        MAX(t215_int_itemnr.c215_active) AS active_fg,
        IF(CASE WHEN active_fg = 1 THEN 1 ELSE 2 END IS NULL, 0, 1) AS cw_win_ord_0,
        CASE WHEN active_fg = 1 THEN 1 ELSE 2 END AS cw_win_ord_1,
        c215_int_itemnr AS cw_win_ord_2
      FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr_2
      WHERE
        t215_int_itemnr.delete_fg IS NULL
      GROUP BY
        1,
        2,
        3
    ) AS cw_win_ss
    QUALIFY
      row_number() OVER (
        PARTITION BY wawi_instanz_kzl, itemnr
        ORDER BY cw_win_ss.cw_win_ord_0 DESC, cw_win_ss.cw_win_ord_1, IF(cw_win_ss.cw_win_ord_2 IS NULL, 0, 1) DESC, cw_win_ss.cw_win_ord_2
      ) = 1
  ) AS iit
    ON itemnr.itemnr = iit.c215_int_itemnr
) AS src
INNER JOIN meta.t_product_variant_key_2 AS vkey /* !!!Without Negative-Key-Capture!!!
                                                    Key must already exist after the T_PRODUCT_VARIANT_2 (FV_SLS_UNK) job. */
  ON vkey.prod_variant_nat_key_nr = src.prod_nr
  AND vkey.dwh_valid_fg = TRUE
  AND vkey.prod_variant_key_type_cd = 'FV_SLS_UNK'
UNION ALL
SELECT DISTINCT
  vkey.prod_variant_sid AS prod_variant_sid,
  'SLS_UNK' AS prod_variant_key_type_cd,
  CONCAT(left(src.wawi_instanz_kzl, 2), '|', CAST(src.itemnr AS STRING)) AS prod_variant_nat_key_nr,
  'FV' AS source_system,
  src.extraction_tmsp AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_WH' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    CONCAT(
      substr(CAST(itemnr.itemnr AS STRING), 1, 16777216),
      '|',
      substr(CAST(itemnr.subitemnr AS STRING), 1, 16777216)
    ) AS prod_variant_nat_key_nr,
    left(iit.wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
    iit.itemnr AS itemnr,
    iit.extraction_tmsp
  FROM (
    SELECT
      subselect.itemnr,
      MIN(subselect.c451_subitemnr) AS subitemnr
    FROM (
      SELECT
        CAST(t451.c451_itemnr AS NUMERIC) AS itemnr,
        t451.c451_subitemnr
      FROM t451
      GROUP BY
        1,
        2
    ) AS subselect
    GROUP BY
      1
    HAVING
      count(*) = 1
  ) AS itemnr
  INNER JOIN (
    SELECT
      cw_win_ss.wawi_instanz_kzl,
      cw_win_ss.itemnr,
      cw_win_ss.c215_int_itemnr,
      cw_win_ss.extraction_tmsp,
      cw_win_ss.active_fg
    FROM (
      SELECT
        t215_int_itemnr.wawi_instanz_kzl,
        round(
          CAST(substr(
            t215_int_itemnr.c215_itemnr,
            1,
            CAST(length(t215_int_itemnr.c215_itemnr) - 4 AS INT64)
          ) AS NUMERIC),
          0
        ) AS itemnr,
        CAST(t215_int_itemnr.c215_int_itemnr AS NUMERIC) AS c215_int_itemnr,
        MIN(t215_int_itemnr.extraction_tmsp) AS extraction_tmsp,
        MAX(t215_int_itemnr.c215_active) AS active_fg,
        IF(CASE WHEN active_fg = 1 THEN 1 ELSE 2 END IS NULL, 0, 1) AS cw_win_ord_0,
        CASE WHEN active_fg = 1 THEN 1 ELSE 2 END AS cw_win_ord_1,
        c215_int_itemnr AS cw_win_ord_2
      FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr_2
      WHERE
        t215_int_itemnr.delete_fg IS NULL
      GROUP BY
        1,
        2,
        3
    ) AS cw_win_ss
    QUALIFY
      row_number() OVER (
        PARTITION BY wawi_instanz_kzl, itemnr
        ORDER BY cw_win_ss.cw_win_ord_0 DESC, cw_win_ss.cw_win_ord_1, IF(cw_win_ss.cw_win_ord_2 IS NULL, 0, 1) DESC, cw_win_ss.cw_win_ord_2
      ) = 1
  ) AS iit
    ON itemnr.itemnr = iit.c215_int_itemnr
) AS src
INNER JOIN meta.t_product_variant_key_2 AS vkey /* !!!Without Negative-Key-Capture!!!
                                                    Key must already exist after the T_PRODUCT_VARIANT_2 (FV_SLS_UNK) job. */
  ON vkey.prod_variant_nat_key_nr = src.prod_variant_nat_key_nr
  AND vkey.dwh_valid_fg = TRUE
  AND vkey.prod_variant_key_type_cd = 'FV_SLS';