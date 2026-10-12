INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  int_org_key_type_cd,
  prod_nr,
  prod_key_type_cd,
  prod_variant_nr,
  prod_variant_key_type_cd,
  local_prod_variant_nr,
  local_prod_variant_name,
  prod_nat_key_nr,
  party_nat_key_nr,
  prod_variant_nat_key_nr,
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
WITH t451 AS (
  SELECT
    * /* FRAMEWORK AND TECHNICAL COLUMNS */
  FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
  WHERE
    src.delete_fg IS NULL
    AND NOT CAST(src.c451_itemnr AS NUMERIC) IN (
      SELECT
        CAST(itemno AS NUMERIC)
      FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_1
      WHERE
        delete_fg IS NULL
        AND NOT itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
    )
  QUALIFY
    row_number() OVER (
      PARTITION BY left(src.wawi_instanz_kzl, 2), src.c451_itemnr, src.c451_subitemnr
      ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
    ) = 1
)
SELECT
  left(src.wawi_instanz_kzl, 2) AS ctrcode,
  'COUNTRY_1' AS int_org_key_type_cd,
  src.itemnr AS prod_nr,
  'FV' AS prod_key_type_cd,
  CONCAT(CAST(src.itemnr AS STRING), '|', CAST(src.subitemnr AS STRING)) AS prod_variant_nr,
  'FV_SLS' AS prod_variant_key_type_cd,
  CONCAT(
    substr(CAST(src.itemnr AS STRING), 1, 16777216),
    '|',
    substr(CAST(src.subitemnr AS STRING), 1, 16777216)
  ) AS local_prod_variant_nr,
  CONCAT(
    coalesce(src.bez_lang, src.deutschtext),
    '|',
    substr(CAST(src.subitemnr AS STRING), 1, 16777216)
  ) AS local_prod_variant_name,
  src.itemnr AS prod_nat_key_nr,
  left(src.wawi_instanz_kzl, 2) AS party_nat_key_nr,
  CONCAT(CAST(src.itemnr AS STRING), '|', CAST(src.subitemnr AS STRING)) AS prod_variant_nat_key_nr,
  'WAWI' AS source_system, /* FRAMEWORK AND TECHNICAL COLUMNS */
  CURRENT_DATE AS extraction_dt,
  src.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
/* Extraction/Filter Logic: */
FROM (
  SELECT
    iit.wawi_instanz_kzl,
    itm.itemnr,
    itm.subitemnr,
    waw.bez_lang,
    waw.deutschtext,
    waw.extraction_tmsp
  FROM (
    SELECT DISTINCT
      CAST(t451.c451_itemnr AS NUMERIC) AS itemnr,
      CAST(t451.c451_subitemnr AS NUMERIC) AS subitemnr
    FROM t451
  ) AS itm
  INNER JOIN (
    SELECT DISTINCT
      src_0.wawi_instanz_kzl,
      round(
        CAST(substr(src_0.c215_itemnr, 1, CAST(length(src_0.c215_itemnr) - 4 AS INT64)) AS NUMERIC),
        0
      ) AS itemnr,
      CAST(src_0.c215_int_itemnr AS NUMERIC) AS int_itemnr
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr_1 AS src_0
    WHERE
      src_0.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY left(src_0.wawi_instanz_kzl, 2), src_0.c215_int_itemnr
        ORDER BY IF(src_0.extraction_tmsp IS NULL, 0, 1), src_0.extraction_tmsp DESC
      ) = 1
  ) AS iit
    ON itm.itemnr = iit.int_itemnr
  LEFT OUTER JOIN (
    SELECT
      artikel.wawi_instanz_kzl,
      CAST(artikel.artnrvier AS NUMERIC) AS itemnr,
      artikel.bez_lang,
      artikel.deutschtext,
      artikel.extraction_tmsp
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_1
    WHERE
      artikel.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY wawi_instanz_kzl, itemnr
        ORDER BY IF(artikel.artikelnr IS NULL, 0, 1) DESC, artikel.artikelnr
      ) = 1
  ) AS waw
    ON iit.wawi_instanz_kzl = waw.wawi_instanz_kzl AND iit.int_itemnr = waw.itemnr
) AS src;

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  int_org_key_type_cd,
  prod_nr,
  prod_key_type_cd,
  prod_variant_nr,
  prod_variant_key_type_cd,
  local_prod_variant_nr,
  local_prod_variant_name,
  prod_nat_key_nr,
  party_nat_key_nr,
  prod_variant_nat_key_nr,
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
  ${src2tgt_temp_table1}_${src_context_area}.ctrcode, /* FRAMEWORK AND TECHNICAL COLUMNS */
  ${src2tgt_temp_table1}_${src_context_area}.int_org_key_type_cd,
  ${src2tgt_temp_table1}_${src_context_area}.prod_nr,
  ${src2tgt_temp_table1}_${src_context_area}.prod_key_type_cd,
  ${src2tgt_temp_table1}_${src_context_area}.prod_variant_nr,
  'FV_LOG' AS prod_variant_key_type_cd,
  ${src2tgt_temp_table1}_${src_context_area}.local_prod_variant_nr,
  ${src2tgt_temp_table1}_${src_context_area}.local_prod_variant_name,
  ${src2tgt_temp_table1}_${src_context_area}.prod_nat_key_nr,
  ${src2tgt_temp_table1}_${src_context_area}.party_nat_key_nr,
  ${src2tgt_temp_table1}_${src_context_area}.prod_variant_nat_key_nr,
  ${src2tgt_temp_table1}_${src_context_area}.source_system, /* FRAMEWORK AND TECHNICAL COLUMNS */
  ${src2tgt_temp_table1}_${src_context_area}.extraction_dt,
  ${src2tgt_temp_table1}_${src_context_area}.dwh_mapping_tmsp,
  ${src2tgt_temp_table1}_${src_context_area}.tf_error_fg,
  ${src2tgt_temp_table1}_${src_context_area}.deleted_fg,
  ${src2tgt_temp_table1}_${src_context_area}.record_id,
  ${src2tgt_temp_table1}_${src_context_area}.filename,
  ${src2tgt_temp_table1}_${src_context_area}.dwh_node_cd,
  ${src2tgt_temp_table1}_${src_context_area}.dwh_load_id
FROM ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
WHERE
  'FV_LOG' = 'FV_SLS';

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  int_org_key_type_cd,
  prod_nr,
  prod_key_type_cd,
  prod_variant_nr,
  prod_variant_key_type_cd,
  local_prod_variant_nr,
  local_prod_variant_name,
  prod_nat_key_nr,
  party_nat_key_nr,
  prod_variant_nat_key_nr,
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
WITH t451 AS (
  SELECT
    src.*
  FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
  WHERE
    src.delete_fg IS NULL
    AND /* FRAMEWORK AND TECHNICAL COLUMNS */ NOT CAST(src.c451_itemnr AS NUMERIC) IN (
      SELECT
        CAST(itemno AS NUMERIC)
      FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_1
      WHERE
        src.delete_fg IS NULL
        AND NOT itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
    )
  QUALIFY
    row_number() OVER (
      PARTITION BY left(src.wawi_instanz_kzl, 2), src.c451_itemnr, src.c451_subitemnr
      ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
    ) = 1
)
SELECT
  left(src.country_iso_cd, 2) AS ctrcode,
  'COUNTRY_1' AS int_org_key_type_cd,
  src.itemnr AS prod_nr,
  'FV' AS prod_key_type_cd,
  src.itemnr AS prod_variant_nr,
  'FV_SLS_UNK' AS prod_variant_key_type_cd,
  substr(CAST(src.itemnr AS STRING), 1, 16777216) AS local_prod_variant_nr,
  coalesce(src.bez_lang, src.deutschtext) AS local_prod_variant_name,
  src.itemnr AS prod_nat_key_nr,
  left(src.country_iso_cd, 2) AS party_nat_key_nr,
  src.itemnr AS prod_variant_nat_key_nr,
  'WAWI' AS source_system, /* FRAMEWORK AND TECHNICAL COLUMNS */
  CURRENT_DATE AS extraction_dt,
  src.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    itm.itemnr,
    iit.country_iso_cd,
    waw.bez_lang,
    waw.deutschtext,
    waw.extraction_tmsp
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
      t026_wawi_item.itemno AS itemnr
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_1
    WHERE
      t026_wawi_item.delete_fg IS NULL
      AND t026_wawi_item.itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
      AND NOT t026_wawi_item.itemno IN (
        SELECT DISTINCT
          CAST(t451.c451_itemnr AS NUMERIC) AS itemnr
        FROM t451
      )
    QUALIFY
      row_number() OVER (
        PARTITION BY itemnr
        ORDER BY IF(t026_wawi_item.seqid IS NULL, 0, 1), t026_wawi_item.seqid DESC
      ) = 1
  ) AS itm
  INNER JOIN (
    SELECT DISTINCT
      src_0.wawi_instanz_kzl AS country_iso_cd,
      round(
        CAST(substr(src_0.c215_itemnr, 1, CAST(length(src_0.c215_itemnr) - 4 AS INT64)) AS NUMERIC),
        0
      ) AS itemnr,
      CAST(src_0.c215_int_itemnr AS NUMERIC) AS int_itemnr
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr_1 AS src_0
    WHERE
      src_0.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY left(country_iso_cd, 2), src_0.c215_int_itemnr
        ORDER BY IF(src_0.extraction_tmsp IS NULL, 0, 1), src_0.extraction_tmsp DESC
      ) = 1
  ) AS iit
    ON itm.itemnr = iit.int_itemnr
  LEFT OUTER JOIN (
    SELECT
      artikel.wawi_instanz_kzl AS country_iso_cd,
      CAST(artikel.artnrvier AS NUMERIC) AS itemnr,
      artikel.bez_lang,
      artikel.deutschtext,
      artikel.extraction_tmsp
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_1
    WHERE
      artikel.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY country_iso_cd, itemnr
        ORDER BY IF(artikel.artikelnr IS NULL, 0, 1) DESC, artikel.artikelnr
      ) = 1
  ) AS waw
    ON iit.country_iso_cd = waw.country_iso_cd AND iit.itemnr = waw.itemnr
) AS src;

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  int_org_key_type_cd,
  prod_nr,
  prod_key_type_cd,
  prod_variant_nr,
  prod_variant_key_type_cd,
  local_prod_variant_nr,
  local_prod_variant_name,
  prod_nat_key_nr,
  party_nat_key_nr,
  prod_variant_nat_key_nr,
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
  ${src2tgt_temp_table1}_${src_context_area}.ctrcode, /* FRAMEWORK AND TECHNICAL COLUMNS */
  ${src2tgt_temp_table1}_${src_context_area}.int_org_key_type_cd,
  ${src2tgt_temp_table1}_${src_context_area}.prod_nr,
  ${src2tgt_temp_table1}_${src_context_area}.prod_key_type_cd,
  ${src2tgt_temp_table1}_${src_context_area}.prod_variant_nr,
  'FV_LOG_UNK' AS prod_variant_key_type_cd,
  ${src2tgt_temp_table1}_${src_context_area}.local_prod_variant_nr,
  ${src2tgt_temp_table1}_${src_context_area}.local_prod_variant_name,
  ${src2tgt_temp_table1}_${src_context_area}.prod_nat_key_nr,
  ${src2tgt_temp_table1}_${src_context_area}.party_nat_key_nr,
  ${src2tgt_temp_table1}_${src_context_area}.prod_variant_nat_key_nr,
  ${src2tgt_temp_table1}_${src_context_area}.source_system, /* FRAMEWORK AND TECHNICAL COLUMNS */
  ${src2tgt_temp_table1}_${src_context_area}.extraction_dt,
  ${src2tgt_temp_table1}_${src_context_area}.dwh_mapping_tmsp,
  ${src2tgt_temp_table1}_${src_context_area}.tf_error_fg,
  ${src2tgt_temp_table1}_${src_context_area}.deleted_fg,
  ${src2tgt_temp_table1}_${src_context_area}.record_id,
  ${src2tgt_temp_table1}_${src_context_area}.filename,
  ${src2tgt_temp_table1}_${src_context_area}.dwh_node_cd,
  ${src2tgt_temp_table1}_${src_context_area}.dwh_load_id
FROM ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
WHERE
  'FV_LOG_UNK' = 'FV_SLS_UNK';