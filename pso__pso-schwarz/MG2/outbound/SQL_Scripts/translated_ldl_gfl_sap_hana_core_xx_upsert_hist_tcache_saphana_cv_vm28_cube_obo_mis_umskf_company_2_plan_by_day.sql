 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 real_estate_key_type_cd, int_org_key_type_cd, int_org_natural_key, real_estate_natural_key, int_org_sid, cal_dt,
 plan_pos_nr, planned_val_type_key_type_cd, planned_val_type_natural_key, planned_kpi_meas, int_org_type_cd)
(SELECT 'SAP_HANA_PLAN' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  MAX(t3.extraction_date) AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  'DUMMY' AS real_estate_key_type_cd,
  'COMPANY' AS int_org_key_type_cd,
  CAST(NULL AS STRING) AS int_org_natural_key,
  'DUMMY|DUMMY' AS real_estate_natural_key,
  int_org_sid0.party_sid AS int_org_sid,
  -- UPPER(VLXMLCNTR)||'|'||TO_NUMBER(VLXMWRNFL) AS INT_ORG_NATURAL_KEY,
  PARSE_DATE('%Y%m%d', t3.calday) AS cal_dt,
  t3.vlxmstore AS plan_pos_nr,
  'PVAL' AS planned_val_type_key_type_cd,
    t3.kyf_id || '|' || CASE
    WHEN t3.urgunit = 50
    THEN 'WH_DLV'
    WHEN t3.urgunit = 60
    THEN 'WH_SLS'
    ELSE NULL
    END AS planned_val_type_natural_key,
  SUM(t3.kyf_all) AS planned_kpi_meas,
  'COMPANY' AS int_org_type_cd
 FROM (SELECT vlxmlcntr,
    calday,
    kyf_id,
    kyf_type,
    kyf_all,
    vlxmstore,
    extraction_date,
    vlxmvers,
    vlxmwrnfl,
    urgunit
   FROM ${temp_db}.t_${src_input_table}
   WHERE CAST(calday AS FLOAT64) <> 0 -- filter out invalid delivered business dates

    AND CAST(kyf_id AS FLOAT64) = 157 -- 157 is "Daily Revenue Value"

    AND CAST(kyf_type AS FLOAT64) = 2 -- 2:"Target/Plan", 1: "Actual"

    AND CAST(urgunit AS INTEGER) IN (50, 60)  -- targets for Delivery(50)/Sales(60) Companies
	--    AND vlxmvers = 'S2324' -- so far this revision ID is the most complete (contains data for highest number of stores)
     -- exclude rows which can be associated with Stores
     -- what is left we will associate with Companies
    AND UPPER(vlxmlcntr) || CAST(ROUND(CAST(vlxmstore AS BIGNUMERIC), 0) AS STRING) NOT IN (SELECT int_org_nr
      FROM ldl_data_production_core_rel.t_internal_organization AS io
      WHERE int_org_type_cd = 'STORE')
    AND kyf_all IS NOT NULL -- eliminated empty target values
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY vlxmlcntr, vlxmstore, calday, vlxmwrnfl ORDER BY extraction_date IS NULL
         DESC, extraction_date DESC, urgunit IS NULL, urgunit)) = 1
     -- For Stores we often get two (some thimes 3) rows per day for the plan turonver.

     -- One is asociated with Sales Company (60/VGES) and the other is associated with Delivery Company (50/BGES). The Company numbers could be the same or different.

     -- If company numbers are the same we take only 1 row, if they are different we take both rows and link them to the respective companies. So we deduplicate by Store,Day AND COMPANY

     -- Duplicated rows have the same  value so we just take one.

     -- BGES has priority over VGES because in LISY we have links between stores and delivery companies
) AS t3
/* SID Lookup is done outside graph, because the key table can deliver more than one sid for the same natural key which in this case is correct */
  INNER JOIN ldl_data_production_meta.t_party_key AS int_org_sid0 ON int_org_sid0.dwh_valid_fg AND UPPER(int_org_sid0.party_key_type_cd
      ) = UPPER('COMPANY') AND UPPER(int_org_sid0.party_nat_key_nr) = UPPER(t3.vlxmlcntr) || '|' || CAST(ROUND(CAST(t3.vlxmwrnfl AS BIGNUMERIC)
       , 0) AS STRING)
 WHERE int_org_sid0.party_sid IS NOT NULL
 GROUP BY int_org_sid,
  int_org_natural_key,
  int_org_key_type_cd,
  int_org_type_cd,
  real_estate_natural_key,
  real_estate_key_type_cd,
  cal_dt,
  planned_val_type_natural_key,
  planned_val_type_key_type_cd,
  plan_pos_nr);