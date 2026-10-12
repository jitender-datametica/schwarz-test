
-- filter out invalid delivered business dates


-- 157 is "Daily Revenue Value"


-- 2:"Target/Plan", 1: "Actual"


-- eliminated empty target values


--    AND vlxmvers = 'S2324' -- so far this revision ID is the most complete (contains data for highest number of stores)


-- For Stores we get two rows per day for the plan turonver.


-- One is asociated with Sales_2 Company (60/VGES) and the other is associated with Delivery Company (50/BGES)


-- They always have the same value so we just take one. 


-- BGES hAS priority over VGES because in LISY we have links between stores and delivery companies


/*SID Lookup is done outside graph, because the key table can deliver more than one sid for the same natural key which in this case is correct*/


-- Only here for a dedupe


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, extraction_dt, dwh_mapping_tmsp, int_org_sid, int_org_type_cd, cal_dt, plan_pos_nr,
 planned_val_type_key_type_cd, planned_val_type_natural_key, planned_kpi_meas, int_org_key_type_cd, int_org_natural_key
 , real_estate_natural_key, real_estate_key_type_cd)
(SELECT 'SAP_HANA_PLAN' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  MAX(SRC.extraction_date) AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  IO.int_org_sid,
  'STORE' AS int_org_type_cd,
  PARSE_DATE('%Y%m%d', SRC.calday) AS cal_dt,
  SRC.vlxmstore AS plan_pos_nr,
  'PVAL' AS planned_val_type_key_type_cd,
    SRC.kyf_id || '|' || 'STR' AS planned_val_type_natural_key,
  SUM(SRC.kyf_all) AS planned_kpi_meas,
  'STORE' AS int_org_key_type_cd,
    UPPER(SRC.vlxmlcntr) || '|' || CAST(ROUND(CAST(SRC.vlxmstore AS BIGNUMERIC), 0) AS STRING) AS int_org_natural_key,
  'DUMMY_2|DUMMY_2' AS real_estate_natural_key,
  'DUMMY_2' AS real_estate_key_type_cd
 FROM (SELECT vlxmlcntr,
    calday,
    kyf_id,
    kyf_type,
    kyf_all,
    vlxmstore,
    extraction_date,
    vlxmvers
   FROM ${temp_db}.${t_src_input_table}
   WHERE CAST(calday AS FLOAT64) <> 0
    AND CAST(kyf_id AS FLOAT64) = 152
    AND CAST(kyf_type AS FLOAT64) = 2
    AND kyf_all IS NOT NULL
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY vlxmlcntr, vlxmstore, calday ORDER BY extraction_date IS NULL DESC,
         extraction_date DESC, urgunit IS NULL, urgunit)) = 1) AS SRC
  INNER JOIN (SELECT int_org_nr,
    MAX(int_org_sid) AS int_org_sid
   FROM ldl_data_production_core_rel.t_internal_organization_2
   WHERE UPPER(int_org_type_cd) = 'STORE'
   GROUP BY int_org_nr) AS IO ON UPPER(IO.int_org_nr) = UPPER(SRC.vlxmlcntr) || CAST(ROUND(CAST(SRC.vlxmstore AS BIGNUMERIC)
      , 0) AS STRING)
 GROUP BY IO.int_org_sid,
  int_org_natural_key,
  int_org_key_type_cd,
  int_org_type_cd,
  real_estate_natural_key,
  real_estate_key_type_cd,
  cal_dt,
  planned_val_type_natural_key,
  planned_val_type_key_type_cd,
  plan_pos_nr);