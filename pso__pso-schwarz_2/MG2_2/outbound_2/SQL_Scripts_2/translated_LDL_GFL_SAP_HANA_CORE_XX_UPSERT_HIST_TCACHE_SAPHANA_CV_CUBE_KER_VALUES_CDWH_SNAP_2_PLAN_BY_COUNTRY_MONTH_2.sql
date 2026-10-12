
--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_2 SRC


--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_2 SRC


--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_2 SRC


--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_2 SRC


--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_2 SRC


--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_2 SRC


--FROM ETL.T_TCACHE_SAPHANA_CV_CUBE_KER_VALUES_CDWH_SNAP_2 SRC


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, plan_pos_nr, planned_val_type_key_type_cd,
 planned_val_type_natural_key, planned_kpi_meas, reporting_country_cd, cal_month)
(SELECT dwh_node_cd,
  tf_error_fg,
  dwh_load_id,
  extraction_dt,
   deleted_fg <> 0 AS deleted_fg,
  CAST(record_id AS STRING) AS record_id,
  dwh_mapping_tmsp,
  filename,
  plan_pos_nr,
  planned_val_type_key_type_cd,
  planned_val_type_natural_key,
  planned_kpi_meas,
  reporting_country_cd,
  calmonth
 FROM (SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS reporting_country_cd,
     calmonth,
     '255|CTR' AS planned_val_type_natural_key,
     'PVAL' AS planned_val_type_key_type_cd,
     '' AS plan_pos_nr,
     kalk_repr_plan AS planned_kpi_meas,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.${t_src_input_table} AS src
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY UPPER(SUBSTR(vlxmlcntr, 1, 2)), calmonth, '255|CTR', '' ORDER BY
          extraction_date IS NULL DESC, extraction_date DESC)) = 1
    UNION ALL
    SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS reporting_country_cd,
     calmonth,
     '256|CTR' AS planned_val_type_natural_key,
     'PVAL' AS planned_val_type_key_type_cd,
     '' AS plan_pos_nr,
     steuern_plan AS planned_kpi_meas,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.${t_src_input_table} AS src
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY UPPER(SUBSTR(vlxmlcntr, 1, 2)), calmonth, '256|CTR', '' ORDER BY
          extraction_date IS NULL DESC, extraction_date DESC)) = 1
    UNION ALL
    SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS reporting_country_cd,
     calmonth,
     '257|CTR' AS planned_val_type_natural_key,
     'PVAL' AS planned_val_type_key_type_cd,
     '' AS plan_pos_nr,
     rvg_plan AS planned_kpi_meas,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.${t_src_input_table} AS src
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY UPPER(SUBSTR(vlxmlcntr, 1, 2)), calmonth, '257|CTR', '' ORDER BY
          extraction_date IS NULL DESC, extraction_date DESC)) = 1
    UNION ALL
    SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS reporting_country_cd,
     calmonth,
     '258|CTR' AS planned_val_type_natural_key,
     'PVAL' AS planned_val_type_key_type_cd,
     '' AS plan_pos_nr,
     nrv_plan AS planned_kpi_meas,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.${t_src_input_table} AS src
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY UPPER(SUBSTR(vlxmlcntr, 1, 2)), calmonth, '258|CTR', '' ORDER BY
          extraction_date IS NULL DESC, extraction_date DESC)) = 1
    UNION ALL
    SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS reporting_country_cd,
     calmonth,
     '259|CTR' AS planned_val_type_natural_key,
     'PVAL' AS planned_val_type_key_type_cd,
     '' AS plan_pos_nr,
     spedition_plan AS planned_kpi_meas,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.${t_src_input_table} AS src
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY UPPER(SUBSTR(vlxmlcntr, 1, 2)), calmonth, '259|CTR', '' ORDER BY
          extraction_date IS NULL DESC, extraction_date DESC)) = 1
    UNION ALL
    SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS reporting_country_cd,
     calmonth,
     '260|CTR' AS planned_val_type_natural_key,
     'PVAL' AS planned_val_type_key_type_cd,
     '' AS plan_pos_nr,
     whrgdiff_plan AS planned_kpi_meas,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.${t_src_input_table} AS src
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY UPPER(SUBSTR(vlxmlcntr, 1, 2)), calmonth, '260|CTR', '' ORDER BY
          extraction_date IS NULL DESC, extraction_date DESC)) = 1
    UNION ALL
    SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS reporting_country_cd,
     calmonth,
     '261CTR' AS planned_val_type_natural_key,
     'PVAL' AS planned_val_type_key_type_cd,
     '' AS plan_pos_nr,
     kalkulation_plan AS planned_kpi_meas,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.${t_src_input_table} AS src
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY UPPER(SUBSTR(vlxmlcntr, 1, 2)), calmonth, '261CTR', '' ORDER BY
          extraction_date IS NULL DESC, extraction_date DESC)) = 1) AS t20);