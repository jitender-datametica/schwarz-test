
--UPPER(VLXMLCNTR)||'|'||TO_NUMBER(VLXMWRNFL) AS INT_ORG_NATURAL_KEY,


-- filter out invalid delivered business dates


-- 152 is Customer Count


-- 2:"Target/Plan", 1: "Actual"


-- eliminated empty target values


-- targets for Delivery(50)/Sales_1(60) Companies


-- so far this revision ID is the most complete (contains data for highest number of stores)


-- exclude rows which can be associated with Stores


-- what is left we will associate with Companies


-- For Stores we often get two (some thimes 3) rows per day for the plan turonver.


-- One is asociated with Sales_1 Company (60/VGES) and the other is associated with Delivery Company (50/BGES). The Company numbers could be the same or different.


-- If company numbers are the same we take only 1 row, if they are different we take both rows and link them to the respective companies. So we deduplicate by Store,Day AND COMPANY


-- Duplicated rows have the same  value so we just take one. 


-- BGES has priority over VGES because in LISY we have links between stores and delivery companies


/*SID Lookup is done outside graph, because the key table can deliver more than one sid for the same natural key which in this case is correct*/


-- There are some rogue countrty codes in the data, we discard them via this CROSS JOIN.


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
  t1.extraction_date AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  io.int_org_sid,
  'COMPANY' AS int_org_type_cd,
  PARSE_DATE('%Y%m%d', t1.calday) AS src_calday,
  t1.vlxmlcntr AS plan_pos_nr,
  'PVAL' AS planned_val_type_key_type_cd,
    t1.kyf_id || '|' || CASE
    WHEN t1.urgunit = 50
    THEN 'WH_DLV'
    WHEN t1.urgunit = 60
    THEN 'WH_SLS'
    ELSE NULL
    END AS planned_val_type_natural_key,
  t1.kyf_all AS planned_kpi_meas,
  'COMPANY' AS int_org_key_type_cd,
  CAST(NULL AS STRING) AS int_org_natural_key,
  'DUMMY_1|DUMMY_1' AS real_estate_natural_key,
  'DUMMY_1' AS real_estate_key_type_cd
 FROM (SELECT vlxmlcntr,
    calday,
    kyf_id,
    kyf_type,
    kyf_all,
    extraction_date,
    vlxmvers,
    urgunit
   FROM ldl_data_production_etl.t_tcache_saphana_cv_mo_umsatz_kunde_1
   WHERE CAST(calday AS FLOAT64) <> 0
    AND CAST(kyf_id AS FLOAT64) = 152
    AND CAST(kyf_type AS FLOAT64) = 2
    AND CAST(urgunit AS INTEGER) IN (50, 60)
    AND vlxmvers = 'S2324'
    AND kyf_all IS NOT NULL
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY vlxmlcntr, calday ORDER BY extraction_date IS NULL DESC, extraction_date
         DESC, urgunit IS NULL, urgunit)) = 1) AS t1_1
  INNER JOIN ldl_data_production_core_rel.t_internal_organization_1 AS io ON io.dwh_valid_fg AND UPPER(io.country_org_cd)
     = UPPER(t1.vlxmlcntr) AND io.is_country_org_fg);