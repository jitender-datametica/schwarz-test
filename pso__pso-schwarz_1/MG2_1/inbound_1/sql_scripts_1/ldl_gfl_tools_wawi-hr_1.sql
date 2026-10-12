DELETE FROM  ETL_PROCESS.T_LOOKUP_INSTR_1 WHERE SOURCE_SYSTEM='wawi-hr';

INSERT INTO ETL_PROCESS.T_LOOKUP_INSTR_1 (COUNTRY_1,TARGET_TABLE,SOURCE_SYSTEM,SOURCE_UNIQUE_NAME,SID_ALIAS,SID_NAME,TABLE_NAME,NATURAL_KEYS,TEMP_ALIAS_KEYS,ADD_TEMPORAL_JOIN,LKP_TABLE_AREA,KEYSPACE_SCHEMA,KEYSPACE_SUBJECT_AREA,KEYSPACE_KEY_TYPE_CD,KEYSPACE_NATURAL_KEY_NAME,KEYSPACE_SID_KEY_NAME) VALUES
	 ('xx','xx','wawi-hr','xx','prod_sid','prod_sid','xx','prod_key','prod_nat_key_nr','no','meta','meta','product','prod_key_type_cd','prod_nat_key_nr','prod_sid'),
	 ('xx','xx','wawi-hr','xx','int_org_sid','int_org_sid','xx','party_key','party_nat_key_nr','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
	 ('xx','xx','wawi-hr','xx','country_org_sid','int_org_sid','xx','party_key','party_nat_key_nr','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
     ('xx','xx','wawi-hr','xx','prod_variant_sid','prod_variant_sid','xx','prod_variant_key','prod_variant_nat_key_nr','no','meta','meta','product_variant','prod_variant_key_type_cd','prod_variant_nat_key_nr','prod_variant_sid'),
	 ('xx','xx','wawi-hr','xx','price_grp_sid','price_grp_sid','xx','price_grp_key','price_grp_nat_key_nr','no','meta','meta','price_group','price_grp_key_type_cd','price_grp_nat_key_nr','price_grp_sid');
