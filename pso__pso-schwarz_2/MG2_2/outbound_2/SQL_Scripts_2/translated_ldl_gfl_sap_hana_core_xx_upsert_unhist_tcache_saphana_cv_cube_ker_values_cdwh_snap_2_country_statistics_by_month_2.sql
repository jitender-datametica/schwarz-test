
--sum values AS we receive double records for Croatia


CREATE TEMPORARY TABLE IF NOT EXISTS t_${src_input_table}_temp AS
SELECT vlxmlcntr,
 extraction_date,
 calmonth,
 SUM(kalk_repr_ist) AS kalk_repr_ist,
 SUM(steuern_ist) AS steuern_ist,
 SUM(rvg_ist) AS rvg_ist,
 SUM(nrv_ist) AS nrv_ist,
 SUM(spedition_ist) AS spedition_ist,
 SUM(whrgdiff_ist) AS whrgdiff_ist,
 SUM(kalkulation_ist) AS kalkulation_ist,
 vlxecukyl
FROM ${temp_db}.t_${src_input_table}
GROUP BY vlxmlcntr,
 extraction_date,
 calmonth,
 vlxecukyl;


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, uom_cd, curr_cd,
 stat_type_cd, stat_qty, stat_dt, stat_cnt, cal_month, stat_meas, stat_val, curr_stat_fg, reporting_country_key_type_cd
 , geo_area_natural_key)
(SELECT dwh_node_cd,
  tf_error_fg,
  dwh_load_id,
  extraction_dt,
   deleted_fg <> 0 AS deleted_fg,
  CAST(record_id AS STRING) AS record_id,
  dwh_mapping_tmsp,
  filename,
  CAST(uom_cd AS STRING) AS uom_cd,
  curr_cd,
  stat_type_cd,
  stat_qty,
  stat_dt,
  stat_cnt,
  calmonth,
  stat_meas,
  stat_val,
   curr_stat_fg <> 0 AS curr_stat_fg,
  reporting_country_key_type_cd,
  geo_area_natural_key
 FROM (SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS geo_area_natural_key,
     'REP_CTRY' AS reporting_country_key_type_cd,
     '255' AS stat_type_cd,
     extraction_date AS stat_dt,
     -- ?
 calmonth,
     1 AS curr_stat_fg,
     kalk_repr_ist AS stat_val,
     vlxecukyl AS curr_cd,
     NULL AS stat_cnt,
     NULL AS stat_qty,
     NULL AS stat_meas,
     NULL AS uom_cd,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     't_${SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM t_${src_input_table}_temp AS src
    UNION ALL
    SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS geo_area_natural_key,
     'REP_CTRY' AS reporting_country_key_type_cd,
     '256' AS stat_type_cd,
     extraction_date AS stat_dt,
     -- ?
 calmonth,
     1 AS curr_stat_fg,
     steuern_ist AS stat_val,
     vlxecukyl AS curr_cd,
     NULL AS stat_cnt,
     NULL AS stat_qty,
     NULL AS stat_meas,
     NULL AS uom_cd,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     't_${SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM t_${src_input_table}_temp AS src
    UNION ALL
    SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS geo_area_natural_key,
     'REP_CTRY' AS reporting_country_key_type_cd,
     '257' AS stat_type_cd,
     extraction_date AS stat_dt,
     -- ?
 calmonth,
     1 AS curr_stat_fg,
     rvg_ist AS stat_val,
     vlxecukyl AS curr_cd,
     NULL AS stat_cnt,
     NULL AS stat_qty,
     NULL AS stat_meas,
     NULL AS uom_cd,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     't_${SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM t_${src_input_table}_temp AS src
    UNION ALL
    SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS geo_area_natural_key,
     'REP_CTRY' AS reporting_country_key_type_cd,
     '258' AS stat_type_cd,
     extraction_date AS stat_dt,
     -- ?
 calmonth,
     1 AS curr_stat_fg,
     nrv_ist AS stat_val,
     vlxecukyl AS curr_cd,
     NULL AS stat_cnt,
     NULL AS stat_qty,
     NULL AS stat_meas,
     NULL AS uom_cd,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     't_${SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM t_${src_input_table}_temp AS src
    UNION ALL
    SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS geo_area_natural_key,
     'REP_CTRY' AS reporting_country_key_type_cd,
     '259' AS stat_type_cd,
     extraction_date AS stat_dt,
     -- ?
 calmonth,
     1 AS curr_stat_fg,
     spedition_ist AS stat_val,
     vlxecukyl AS curr_cd,
     NULL AS stat_cnt,
     NULL AS stat_qty,
     NULL AS stat_meas,
     NULL AS uom_cd,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     't_${SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM t_${src_input_table}_temp AS src
    UNION ALL
    SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS geo_area_natural_key,
     'REP_CTRY' AS reporting_country_key_type_cd,
     '260' AS stat_type_cd,
     extraction_date AS stat_dt,
     -- ?
 calmonth,
     1 AS curr_stat_fg,
     whrgdiff_ist AS stat_val,
     vlxecukyl AS curr_cd,
     NULL AS stat_cnt,
     NULL AS stat_qty,
     NULL AS stat_meas,
     NULL AS uom_cd,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     't_${SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM t_${src_input_table}_temp AS src
    UNION ALL
    SELECT UPPER(SUBSTR(vlxmlcntr, 1, 2)) AS geo_area_natural_key,
     'REP_CTRY' AS reporting_country_key_type_cd,
     '261' AS stat_type_cd,
     extraction_date AS stat_dt,
     -- ?
 calmonth,
     1 AS curr_stat_fg,
     kalkulation_ist AS stat_val,
     vlxecukyl AS curr_cd,
     NULL AS stat_cnt,
     NULL AS stat_qty,
     NULL AS stat_meas,
     NULL AS uom_cd,
     extraction_date AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     't_${SRC_INPUT_TABLE}' AS filename,
     'SAP_HANA' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM t_${src_input_table}_temp AS src) AS t6);