
--


--, 'OSO' AS DWH_NODE_CD


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, int_org_sid, dwh_ending_tmsp,
 int_org_hierarchy_type_cd, parent_int_org_sid)
(SELECT src.dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'OSO' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(CASE
    WHEN src.derived_valid_from_tmsp IS NOT NULL
    THEN CAST(src.derived_valid_from_tmsp AS STRING)
    WHEN src.lvl = 'SMD' AND tgt.int_org_sid IS NULL
    THEN CAST(IFNULL(io.open_dt, CAST('1900-01-01 00:00:00.000000000' AS DATE)) AS STRING)
    WHEN src.lvl <> 'SMD' AND tgt.int_org_sid IS NULL
    THEN '1900-01-01 00:00:00.000000000'
    ELSE CAST(IFNULL(src.extraction_tmsp, CAST('1900-01-01 00:00:00.000000000' AS TIMESTAMP)) AS
     STRING)
    END AS TIMESTAMP) AS dwh_mapping_tmsp,
  src.int_org_sid,
  COALESCE(src.derived_valid_to_tmsp, tgt.dwh_valid_to_tmsp, CAST('0000-01-01 00:00:00' AS DATETIME)) AS dwh_ending_tmsp
  ,
  src.int_org_hierarchy_type_cd,
  src.parent_int_org_sid
 FROM ldl_data_production_etl.t_tcache_oso_internal_organization_hierarchy_1 AS src
  LEFT JOIN ldl_data_production_core_rel.t_internal_organization_hierarchy_1 AS tgt ON src.int_org_hierarchy_type_cd = tgt
      .int_org_hierarchy_type_cd AND src.int_org_sid = tgt.int_org_sid AND src.dwh_node_cd = tgt.dwh_node_cd AND src.extraction_tmsp
    BETWEEN tgt.dwh_valid_from_tmsp AND tgt.dwh_valid_to_tmsp
  LEFT JOIN ldl_data_production_core_rel.t_internal_organization_1 AS io ON src.int_org_sid = io.int_org_sid AND io.int_org_type_cd
      = 'STORE' AND io.dwh_valid_fg);