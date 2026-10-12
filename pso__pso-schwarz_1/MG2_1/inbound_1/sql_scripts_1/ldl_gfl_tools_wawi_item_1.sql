DELETE FROM  ETL_PROCESS.T_LOOKUP_INSTR_1 WHERE SOURCE_SYSTEM='wawi' and target_table in ('t_wawi_item_1','t_wawi_item_variant_1','t_wawi_item_variant_sales_price_1');

INSERT INTO ETL_PROCESS.T_LOOKUP_INSTR_1 (COUNTRY_1,TARGET_TABLE,SOURCE_SYSTEM,SOURCE_UNIQUE_NAME,SID_ALIAS,SID_NAME,TABLE_NAME,NATURAL_KEYS,TEMP_ALIAS_KEYS,ADD_TEMPORAL_JOIN,LKP_TABLE_AREA,KEYSPACE_SCHEMA,KEYSPACE_SUBJECT_AREA,KEYSPACE_KEY_TYPE_CD,KEYSPACE_NATURAL_KEY_NAME,KEYSPACE_SID_KEY_NAME) VALUES
	 ('xx','t_wawi_item_variant_1','wawi','xx','country_org_sid'  ,'country_org_sid'  ,'xx','country_org_nat_key','country_org_nat_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
	 ('xx','t_wawi_item_variant_1','wawi','xx','wawi_item_variant_sid','wawi_item_variant_sid','xx','wawi_item_variant_nat_key_nr','wawi_item_variant_nat_key_nr','no','meta','meta','wawi_item_variant','wawi_item_variant_key_type_cd','wawi_item_variant_nat_key_nr','wawi_item_variant_sid'),
	 ('xx','t_wawi_item_variant_1','wawi','xx','wawi_item_sid','wawi_item_sid','xx','wawi_item_nat_key_nr','wawi_item_nat_key_nr','no','meta','meta','wawi_item_1','wawi_item_key_type_cd','wawi_item_nat_key_nr','wawi_item_sid'),
	 ('xx','t_wawi_item_1','wawi','xx','wawi_item_sid','wawi_item_sid','xx','wawi_item_nat_key_nr','wawi_item_nat_key_nr','no','meta','meta','wawi_item_1','wawi_item_key_type_cd','wawi_item_nat_key_nr','wawi_item_sid'),
         ('xx','t_wawi_item_1','wawi','xx','country_org_sid'  ,'country_org_sid'  ,'xx','country_org_nat_key','country_org_nat_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
         ('xx','t_wawi_item_variant_sales_price_1','wawi','xx','price_grp_sid'  ,'price_grp_sid'  ,'xx','price_grp_nat_key_nr','price_grp_nat_key_nr','no','meta','meta','price_group','price_grp_key_type_cd','price_grp_nat_key_nr','price_grp_sid'),
         ('xx','t_wawi_item_variant_sales_price_1','wawi','xx','wawi_item_variant_sid','wawi_item_variant_sid','xx','wawi_item_variant_nat_key_nr','wawi_item_variant_nat_key_nr','no','meta','meta','wawi_item_variant','wawi_item_variant_key_type_cd','wawi_item_variant_nat_key_nr','wawi_item_variant_sid')
	;
