DELETE FROM  ETL_PROCESS.T_LOOKUP_INSTR_1 WHERE SOURCE_SYSTEM='event';

INSERT INTO ETL_PROCESS.T_LOOKUP_INSTR_1 (COUNTRY_1,TARGET_TABLE,SOURCE_SYSTEM,SOURCE_UNIQUE_NAME,SID_ALIAS,SID_NAME,TABLE_NAME,NATURAL_KEYS,TEMP_ALIAS_KEYS,ADD_TEMPORAL_JOIN,LKP_TABLE_AREA,KEYSPACE_SCHEMA,KEYSPACE_SUBJECT_AREA,KEYSPACE_KEY_TYPE_CD,KEYSPACE_NATURAL_KEY_NAME,KEYSPACE_SID_KEY_NAME) VALUES
	 ('xx','t_planned_value_type_1','event','xx','planned_val_type_sid','planned_val_type_sid','xx','planned_val_type_key_natural_key','planned_val_type_key_natural_key','no','meta','meta','planned_value_type','planned_val_type_key_type_cd','planned_val_type_nat_key_nr','planned_val_type_sid');
