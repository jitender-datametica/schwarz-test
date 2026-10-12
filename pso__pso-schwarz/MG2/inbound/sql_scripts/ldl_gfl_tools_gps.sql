DELETE FROM  ETL_PROCESS.T_LOOKUP_INSTR WHERE SOURCE_SYSTEM='gps';

INSERT INTO ETL_PROCESS.T_LOOKUP_INSTR (COUNTRY,TARGET_TABLE,SOURCE_SYSTEM,SOURCE_UNIQUE_NAME,SID_ALIAS,SID_NAME,TABLE_NAME,NATURAL_KEYS,TEMP_ALIAS_KEYS,ADD_TEMPORAL_JOIN,LKP_TABLE_AREA,KEYSPACE_SCHEMA,KEYSPACE_SUBJECT_AREA,KEYSPACE_KEY_TYPE_CD,KEYSPACE_NATURAL_KEY_NAME,KEYSPACE_SID_KEY_NAME) VALUES
	 ('xx','t_employee_time_tracking','gps','xx','int_org_sid','int_org_sid','xx','int_org_natural_key','int_org_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
	 ('xx','t_employee_time_tracking','gps','xx','country_org_sid','country_org_sid','xx','country_org_natural_key','country_org_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
	 ('xx','t_employee_time_tracking','gps','xx','emp_tm_period_type_sid','emp_tm_period_type_sid','xx','emp_tm_period_type_natural_key','emp_tm_period_type_natural_key','no','meta','meta','employee_time_period_type','emp_tm_period_type_key_type_cd','emp_tm_period_type_nat_key_nr','emp_tm_period_type_sid'),
	 ('xx','t_employee_time_period_type','gps','xx','int_company_sid','int_company_sid','xx','int_company_natural_key','int_company_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
	 ('xx','t_employee_time_period_type','gps','xx','emp_tm_period_type_sid','emp_tm_period_type_sid','xx','emp_tm_period_type_natural_key','emp_tm_period_type_natural_key','no','meta','meta','employee_time_period_type','emp_tm_period_type_key_type_cd','emp_tm_period_type_nat_key_nr','emp_tm_period_type_sid')
;
