

 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , bus_dt, country_org_sid, real_estate_sid, country_org_cd, curr_cd, int_org_sid, int_org_type_cd, accrual_dt,
 curr_accrual_fg, turnover_net_val, receipt_cnt)
(SELECT 'SAP_HANA' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'SAP_HANA',
  CAST(CURRENT_TIMESTAMP() AS DATE),
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  SRC.bus_dt,
  SRC.country_org_sid,
  SRC.real_estate_sid,
  COALESCE(org.country_org_cd, '-1') AS org_country_org_cd,
  SRC.curr_cd,
  SRC.int_org_sid,
  SRC.int_org_type_cd,
  SRC.accrual_dt,
  CAST('false' AS BOOL),
  SRC.turnover_net_val,
  SRC.receipt_cnt
 FROM (SELECT int_org_sid,
    int_org_type_cd,
    real_estate_sid,
    bus_dt,
    MAX(accrual_dt) AS accrual_dt,
    MAX(country_org_sid) AS country_org_sid,
    MAX(curr_cd) AS curr_cd,
    SUM(receipt_cnt) AS receipt_cnt,
    SUM(turnover_net_val) AS turnover_net_val
   FROM ${temp_db}.t_${src_input_table}
   WHERE object_type IN ('20', '90')
    AND bus_dt BETWEEN IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 600 MONTH))
      , DATE_ADD(CURRENT_DATE, INTERVAL - 600 MONTH)) AND (DATE_SUB(CURRENT_DATE, INTERVAL EXTRACT(DAY FROM CURRENT_DATE
        ) DAY)) -- 50 Years
   GROUP BY bus_dt,
    real_estate_sid,
    int_org_sid,
    int_org_type_cd) AS SRC
  LEFT JOIN ${target_db}.t_internal_organization_2 AS org ON SRC.country_org_sid = org.int_org_sid AND
   org.dwh_valid_fg);