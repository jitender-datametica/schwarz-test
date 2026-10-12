TRUNCATE TABLE   ldl_data_production.${target_db}.${tgt_target_table};

INSERT INTO ldl_data_production.${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  extraction_tmsp,
  wgi_id,
  nat_wgi_id,
  item_group,
  date_from,
  date_to,
  version,
  int_desc,
  nat_desc,
  remarks,
  moduser,
  moddate,
  scn,
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
  left(src.ctrcode, 2) AS ctrcode,
  src.extraction_tmsp,
  src.c711_wgi_id,
  src.c711_nat_wgi_id,
  src.c711_item_group,
  src.c711_date_from,
  src.c711_date_to,
  src.c711_version,
  src.c711_int_desc,
  src.c711_nat_desc,
  src.c711_remarks,
  src.c711_moduser,
  src.c711_moddate,
  src.scn,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  CAST('0' AS NUMERIC) AS tf_error_fg,
  CAST('0' AS NUMERIC) AS deleted_fg,
  CAST('0' AS NUMERIC) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM ldl_data_production.${temp_db}.${src_input_table} AS src
INNER JOIN ldl_data_production.etl.wawi_control_table_2 AS ctrl
  ON ctrl.source_table_name = upper(
    'LDL_DATA_PRODUCTION.${TEMP_DB}.${SRC_INPUT_TABLE}'
  )
  AND ctrl.source_status = 'A'
  AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
INNER JOIN (
  SELECT
    a.ctrcode,
    rank() OVER (
      ORDER BY IF(
        CASE
          WHEN a.ctrcode = 'DE'
          THEN CAST('1' AS NUMERIC)
          WHEN NOT a.ctrcode IN ('BG', 'CY', 'GR')
          THEN CAST('2' AS NUMERIC)
          WHEN a.ctrcode = 'GR'
          THEN CAST('3' AS NUMERIC)
          WHEN a.ctrcode IN ('BG', 'CY')
          THEN CAST('4' AS NUMERIC)
        END IS NULL,
        0,
        1
      ) DESC, CASE
        WHEN a.ctrcode = 'DE'
        THEN CAST('1' AS NUMERIC)
        WHEN NOT a.ctrcode IN ('BG', 'CY', 'GR')
        THEN CAST('2' AS NUMERIC)
        WHEN a.ctrcode = 'GR'
        THEN CAST('3' AS NUMERIC)
        WHEN a.ctrcode IN ('BG', 'CY')
        THEN CAST('4' AS NUMERIC)
      END, IF(a.ctrcode IS NULL, 0, 1) DESC, a.ctrcode
    ) AS eks_rank
  FROM (
    SELECT DISTINCT
      ${src_input_table}.ctrcode
    FROM ldl_data_production.${temp_db}.${src_input_table}
  ) AS a
) AS csrc
  ON src.ctrcode = csrc.ctrcode
QUALIFY
  csrc.eks_rank = MIN(csrc.eks_rank) OVER (PARTITION BY src.c711_wgi_id, src.c711_nat_wgi_id, src.c711_item_group)
  AND row_number() OVER (
    PARTITION BY src.c711_wgi_id, src.c711_nat_wgi_id, src.c711_item_group, src.c711_date_from, src.ctrcode
    ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
  ) = CAST('1' AS NUMERIC);