INSERT INTO ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
  int_org_key_type_cd, 
  party_nat_key_nr, 
  int_org_type_cd, 
  stat_type_cd, 
  stat_dt, 
  cal_month, 
  curr_stat_fg, 
  stat_src_cd, 
  stat_val, 
  curr_cd, 
  stat_cnt, 
  stat_qty, 
  stat_pct, 
  stat_meas, 
  uom_cd, 

  source_system, 
  extraction_date, 
  dwh_mapping_tmsp, 
  tf_error_fg, 
  deleted_fg, 
  record_id, 
  filename, 
  dwh_node_cd, 
  dwh_load_id
)
WITH source AS 
(
  SELECT 
    prt.party_sid,
    ANY_VALUE(int_org_key_type_cd) AS int_org_key_type_cd, 
    ANY_VALUE(sap.party_nat_key_nr) AS party_nat_key_nr, 
    ANY_VALUE(int_org_type_cd) AS int_org_type_cd, 
    stat_dt, 
    cal_month, 
    ANY_VALUE(curr_stat_fg) AS curr_stat_fg, 
    ANY_VALUE(curr_cd) AS curr_cd, 
    ANY_VALUE(source_system) AS source_system,
    ANY_VALUE(extraction_date) AS extraction_date,        
    ANY_VALUE(dwh_mapping_tmsp) AS dwh_mapping_tmsp,
    ANY_VALUE(tf_error_fg) AS tf_error_fg,
    ANY_VALUE(deleted_fg) AS deleted_fg,
    ANY_VALUE(record_id) AS record_id,
    ANY_VALUE(filename) AS filename,
    ANY_VALUE(sap.dwh_node_cd) AS dwh_node_cd,
    ANY_VALUE(sap.dwh_load_id) AS dwh_load_id,
    SUM(zxxkanz18) AS zxxkanz18,
    SUM(zxxknum13) AS zxxknum13,
    SUM(zxxkanz08) AS zxxkanz08,
    SUM(zxxknum30) AS zxxknum30 
  FROM
  (
    SELECT
      CASE
        WHEN gxxmlfilb != '' THEN 'STORE'
        WHEN gxxmlfilb = '' AND g90mgestx != 'GES' AND g90mgestx != '' THEN 'COMPANY'
        WHEN gxxmlfilb = '' AND g90mgestx = '' THEN 'COUNTRY_2'
      END AS int_org_key_type_cd,
      CASE
        WHEN gxxmlfilb != '' THEN CONCAT(LEFT(gxxmlfilb,2), '|', LTRIM(RIGHT(gxxmlfilb,4), '0'))
        WHEN gxxmlfilb = '' AND g90mgestx != 'GES' AND g90mgestx != '' THEN CONCAT(gxxmlland, '|', g90mgestx___t)
        WHEN gxxmlfilb = '' AND g90mgestx = '' THEN gxxmlland
      END AS party_nat_key_nr,
      CASE
        WHEN gxxmlfilb != '' THEN 'STORE'
        WHEN gxxmlfilb = '' AND g90mgestx != 'GES' AND g90mgestx != '' THEN 'COMPANY'
        WHEN gxxmlfilb = '' AND g90mgestx = '' THEN 'COMPANY'
      END AS int_org_type_cd,
      extraction_date AS stat_dt,
      _zero_calmonth AS cal_month,
      1 AS curr_stat_fg,
      curr_cd, 
      UPPER(source_system) AS source_system,
      extraction_ts AS extraction_date,
      CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
      0 AS tf_error_fg,
      0 AS deleted_fg,
      0 AS record_id,
      't_${SRC_INPUT_TABLE}' AS filename,
      'SAP_HANA' AS dwh_node_cd,
      '${LOAD_ID}' AS dwh_load_id,
      zxxkanz18,
      zxxknum13,
      zxxkanz08,
      zxxknum30
    FROM ldl_data_production_etl.t_tcache_saphana_lpa906901_2 s
    JOIN ldl_data_production_meta.t_party_key_2 k
      ON k.party_key_type_cd = 'COUNTRY_2'
     AND k.party_nat_key_nr = s.gxxmlland
     AND k.dwh_valid_fg
    JOIN ldl_data_production_core_rel.t_internal_organization_2 org
      ON org.int_org_sid = k.party_sid
     AND org.dwh_valid_fg
    WHERE (gxxmlfilb != '')
       OR (gxxmlfilb = '' AND g90mgestx != 'GES' AND g90mgestx != '')
       OR (gxxmlfilb = '' AND g90mgestx = '')
  ) sap
  JOIN ldl_data_production_meta.t_party_key_2 prt
    ON prt.dwh_valid_fg
   AND prt.party_key_type_cd = int_org_key_type_cd
   AND prt.party_nat_key_nr = sap.party_nat_key_nr
  GROUP BY party_sid, stat_dt, cal_month
)
SELECT
  int_org_key_type_cd, 
  party_nat_key_nr, 
  int_org_type_cd, 
  'EMP_TURNOVER' AS stat_type_cd, 
  stat_dt, 
  cal_month, 
  curr_stat_fg, 
  'ZXXKANZ18-1303502' AS stat_src_cd, 
  zxxkanz18 AS stat_val, 
  curr_cd, 
  NULL AS stat_cnt, 
  NULL AS stat_qty, 
  NULL AS stat_pct, 
  NULL AS stat_meas, 
  NULL AS uom_cd, 
  source_system, 
  extraction_date, 
  dwh_mapping_tmsp, 
  tf_error_fg, 
  deleted_fg, 
  record_id, 
  filename, 
  dwh_node_cd, 
  dwh_load_id
FROM source

UNION ALL

SELECT
  int_org_key_type_cd, 
  party_nat_key_nr, 
  int_org_type_cd, 
  'EMP_CAP_TURNOVER' AS stat_type_cd, 
  stat_dt, 
  cal_month, 
  curr_stat_fg, 
  'ZXXKNUM13-1303502' AS stat_src_cd, 
  zxxknum13 AS stat_val, 
  curr_cd, 
  NULL AS stat_cnt, 
  NULL AS stat_qty, 
  NULL AS stat_pct, 
  NULL AS stat_meas, 
  NULL AS uom_cd, 
  source_system, 
  extraction_date, 
  dwh_mapping_tmsp, 
  tf_error_fg, 
  deleted_fg, 
  record_id, 
  filename, 
  dwh_node_cd, 
  dwh_load_id
FROM source

UNION ALL

SELECT
  int_org_key_type_cd, 
  party_nat_key_nr, 
  int_org_type_cd, 
  'INTERNAL_HEAD' AS stat_type_cd, 
  stat_dt, 
  cal_month, 
  curr_stat_fg, 
  'ZXXKANZ08-1303507' AS stat_src_cd, 
  zxxkanz08 AS stat_val, 
  curr_cd, 
  NULL AS stat_cnt, 
  NULL AS stat_qty, 
  NULL AS stat_pct, 
  NULL AS stat_meas, 
  NULL AS uom_cd, 
  source_system, 
  extraction_date, 
  dwh_mapping_tmsp, 
  tf_error_fg, 
  deleted_fg, 
  record_id, 
  filename, 
  dwh_node_cd, 
  dwh_load_id
FROM source

UNION ALL

SELECT
  int_org_key_type_cd, 
  party_nat_key_nr, 
  int_org_type_cd, 
  'INTERNAL_EMP' AS stat_type_cd, 
  stat_dt, 
  cal_month, 
  curr_stat_fg, 
  'ZXXKNUM30-1303508' AS stat_src_cd, 
  zxxknum30 AS stat_val, 
  curr_cd, 
  NULL AS stat_cnt, 
  NULL AS stat_qty, 
  NULL AS stat_pct, 
  NULL AS stat_meas, 
  NULL AS uom_cd, 
  source_system, 
  extraction_date, 
  dwh_mapping_tmsp, 
  tf_error_fg, 
  deleted_fg, 
  record_id, 
  filename, 
  dwh_node_cd, 
  dwh_load_id
FROM source
;
