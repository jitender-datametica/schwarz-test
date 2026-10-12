DELETE FROM  ETL_PROCESS.T_LOOKUP_INSTR_2 WHERE SOURCE_SYSTEM='ptm';

INSERT INTO ETL_PROCESS.T_LOOKUP_INSTR_2 (COUNTRY_2,TARGET_TABLE,SOURCE_SYSTEM,SOURCE_UNIQUE_NAME,SID_ALIAS,SID_NAME,TABLE_NAME,NATURAL_KEYS,TEMP_ALIAS_KEYS,ADD_TEMPORAL_JOIN,LKP_TABLE_AREA,KEYSPACE_SCHEMA,KEYSPACE_SUBJECT_AREA,KEYSPACE_KEY_TYPE_CD,KEYSPACE_NATURAL_KEY_NAME,KEYSPACE_SID_KEY_NAME) VALUES
	 ('xx','t_tcache_ptm_pze4_ptm_plantimeday_2','ptm','xx','int_org_sid','int_org_sid','xx','int_org_natural_key','int_org_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
	 ('xx','t_plan_by_day_2','ptm','xx','planned_val_type_sid','planned_val_type_sid','xx','planned_val_type_natural_key','planned_val_type_natural_key','no','meta','meta','planned_value_type','planned_val_type_key_type_cd','planned_val_type_nat_key_nr','planned_val_type_sid'),
	 ('xx','t_employee_time_tracking_2','ptm','xx','int_org_sid','int_org_sid','xx','int_org_natural_key','int_org_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
	 ('xx','t_employee_time_tracking_2','ptm','xx','country_org_sid','country_org_sid','xx','country_org_natural_key','country_org_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
	 ('xx','t_employee_time_tracking_2','ptm','xx','emp_tm_period_type_sid','emp_tm_period_type_sid','xx','emp_tm_period_type_natural_key','emp_tm_period_type_natural_key','no','meta','meta','employee_time_period_type','emp_tm_period_type_key_type_cd','emp_tm_period_type_nat_key_nr','emp_tm_period_type_sid'),
	 ('xx','t_employee_time_period_type_2','ptm','xx','int_company_sid','int_company_sid','xx','int_company_natural_key','int_company_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
	 ('xx','t_employee_time_period_type_2','ptm','xx','emp_tm_period_type_sid','emp_tm_period_type_sid','xx','emp_tm_period_type_natural_key','emp_tm_period_type_natural_key','no','meta','meta','employee_time_period_type','emp_tm_period_type_key_type_cd','emp_tm_period_type_nat_key_nr','emp_tm_period_type_sid')
;
