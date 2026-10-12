DELETE FROM  ETL_PROCESS.T_LOOKUP_INSTR_2 WHERE SOURCE_SYSTEM='pep';

INSERT INTO ETL_PROCESS.T_LOOKUP_INSTR_2 (COUNTRY_2,TARGET_TABLE,SOURCE_SYSTEM,SOURCE_UNIQUE_NAME,SID_ALIAS,SID_NAME,TABLE_NAME,NATURAL_KEYS,TEMP_ALIAS_KEYS,ADD_TEMPORAL_JOIN,LKP_TABLE_AREA,KEYSPACE_SCHEMA,KEYSPACE_SUBJECT_AREA,KEYSPACE_KEY_TYPE_CD,KEYSPACE_NATURAL_KEY_NAME,KEYSPACE_SID_KEY_NAME) VALUES
	 ('xx','t_tcache_pep_gps_plantimeday_2','pep','xx','int_org_sid','int_org_sid','xx','int_org_natural_key','int_org_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
	 ('xx','t_plan_by_day_2','pep','xx','planned_val_type_sid','planned_val_type_sid','xx','planned_val_type_natural_key','planned_val_type_natural_key','no','meta','meta','planned_value_type','planned_val_type_key_type_cd','planned_val_type_nat_key_nr','planned_val_type_sid');

;
