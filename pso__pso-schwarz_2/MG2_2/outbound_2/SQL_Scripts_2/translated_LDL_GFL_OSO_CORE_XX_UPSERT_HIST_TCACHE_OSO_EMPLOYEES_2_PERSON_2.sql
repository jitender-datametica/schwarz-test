
--    FRAMEWORK AND TECHNICAL COLUMNS


-- look up PERSON_SID in t_party_sid where party_key_type_cd = 'PERSON'


/*  */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, party_nat_key_nr, hire_dt, first_name, gender_cd
 , birth_dt, family_name, emp_nr, is_buyer_fg, is_data_steward_fg, is_cashier_fg, buyer_nr, person_key_type_cd,
 is_cust_fg, term_dt, mgr_emp_sid, is_emp_fg)
(SELECT 'OSO' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'OSO' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  LOWER(empl.mail) AS party_nat_key_nr,
  CAST(NULL AS DATE) AS hire_dt,
  TRANSLATE(empl.firstname, sc.country_from_special_char_list || LOWER(sc.country_from_special_char_list), sc.country_to_special_char_list
     || LOWER(sc.country_to_special_char_list)) AS first_name,
  'U' AS gender_cd,
  CAST(NULL AS DATE) AS birth_dt,
  TRANSLATE(empl.lastname, sc.country_from_special_char_list || LOWER(sc.country_from_special_char_list), sc.country_to_special_char_list
     || LOWER(sc.country_from_special_char_list)) AS family_name,
  empl.workforceid AS emp_nr,
  FALSE AS is_buyer_fg,
  FALSE AS is_data_steward_fg,
  FALSE AS is_cashier_fg,
  CAST(NULL AS STRING) AS buyer_nr,
  'PERSON' AS person_key_type_cd,
  FALSE AS is_cust_fg,
  CAST(NULL AS DATE) AS term_dt,
  NULL AS mgr_emp_sid,
  TRUE AS is_emp_fg
 FROM ldl_data_production_etl.t_tcache_oso_employees_2 AS empl
  INNER JOIN ldl_data_production_etl_process.t_country_special_char_2 AS sc ON TRUE
 WHERE empl.mail LIKE '%@%'
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY party_nat_key_nr ORDER BY empl.extraction_timestamp IS NULL DESC, empl.extraction_timestamp
       DESC)) = 1);