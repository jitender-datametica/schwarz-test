
/* All SIDs are generated in the previous process.
   Use the allocated to access the internal organisation table to enrich
   country_org_cd and curr_cd
*/


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 event_start_tmsp, event_end_tmsp, bus_dt, cashier_nr, auth_by_nr, turnover_relevant_fg, cash_register_type_cd,
 cash_register_usg_type_cd, cust_sid, country_org_sid, cash_register_sid, store_sid, retail_event_sid, real_estate_sid,
 country_org_cd, curr_cd, cash_register_event_nr, training_fg, suspend_fg, cancel_fg, offline_fg, txn_vat_val,
 cust_ident_type_cd, paym_tm_sec_meas, txn_net_val, keyed_lines_cnt, txn_gross_val, scanned_lines_cnt,
 retail_event_type_cd, service_tm_sec_meas, retail_event_scenario_id, cont_retail_event_sid)
(SELECT 'EJR' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'EJR' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  src.event_start_tmsp,
  src.event_end_tmsp,
  src.bus_dt,
  IF(src.bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL SAFE_CAST(- CAST(src.${retention_period_cashier_nr} AS FLOAT64)
      as INTEGER) WEEK), SUBSTR(SAFE_CAST(- 1 as STRING), 1, 10), src.checker_id) AS cashier_nr,
  IF(src.bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL SAFE_CAST(- CAST(src.${retention_period_cashier_nr} AS FLOAT64)
      as INTEGER) WEEK), SUBSTR(SAFE_CAST(- 1 as STRING), 1, 10), src.receiptline_authority_id) AS auth_by_nr,
  src.turnover_relevant_fg,
  src.pos_type AS cash_register_type_cd,
  src.cash_register_usg_type_cd,
  src.cust_sid,
  src.country_org_sid,
  src.cash_register_sid,
  src.store_sid,
  src.retail_event_sid,
  src.real_estate_sid,
  org.country_org_cd,
  org.curr_cd,
  src.cash_register_event_nr,
  src.training_fg,
  src.suspend_fg,
  src.cancel_fg,
  src.offline_fg,
  src.txn_vat_val,
  src.cust_ident_type_cd,
  src.paym_tm_sec_meas,
  src.txn_net_val,
  src.keyed_lines_cnt,
  src.txn_gross_val,
  src.scanned_lines_cnt,
  src.retail_event_type_cd,
  src.service_tm_sec_meas,
  src.retail_event_scenario_id,
  src.cont_retail_event_sid
 FROM ${temp_db}.t_${src_input_table} AS src
  LEFT JOIN ${target_db}.t_internal_organization AS org ON src.country_org_sid = org.int_org_sid AND
    src.bus_dt BETWEEN CAST(org.dwh_valid_from_tmsp AS DATE) AND (CAST(org.dwh_valid_to_tmsp AS DATE)));