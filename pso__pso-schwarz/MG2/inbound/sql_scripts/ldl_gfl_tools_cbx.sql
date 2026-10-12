DELETE FROM  ETL_PROCESS.T_LOOKUP_INSTR WHERE SOURCE_SYSTEM='cbx';

INSERT INTO ETL_PROCESS.T_LOOKUP_INSTR (COUNTRY,TARGET_TABLE,SOURCE_SYSTEM,SOURCE_UNIQUE_NAME,SID_ALIAS,SID_NAME,TABLE_NAME,NATURAL_KEYS,TEMP_ALIAS_KEYS,ADD_TEMPORAL_JOIN,LKP_TABLE_AREA,KEYSPACE_SCHEMA,KEYSPACE_SUBJECT_AREA,KEYSPACE_KEY_TYPE_CD,KEYSPACE_NATURAL_KEY_NAME,KEYSPACE_SID_KEY_NAME) VALUES
	 ('xx','t_product_internal_organization_status','cbx','xx','prod_sid','prod_sid','xx','prod_nr','prod_nr','no','meta','meta','product','prod_key_type_cd','prod_nat_key_nr','prod_sid'),
	 ('xx','t_product_internal_organization_status','cbx','xx','int_org_sid','party_sid','xx','ctrcode','ctrcode','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
	 ('xx','t_product_variant','cbx','xx','prod_variant_sid','prod_variant_sid','xx','prod_variant_nr','prod_variant_nr','no','meta','meta','product_variant','prod_variant_key_type_cd','prod_variant_nat_key_nr','prod_variant_sid'),
	 ('xx','t_local_product_variant','cbx','xx','prod_variant_sid','prod_variant_sid','xx','local_prod_variant_nr','local_prod_variant_nr','no','meta','meta','product_variant','prod_variant_key_type_cd','prod_variant_nat_key_nr','prod_variant_sid'),
	 ('xx','t_product_variant','cbx','xx','prod_sid','prod_sid','xx','prod_nr','prod_nr','no','meta','meta','product','prod_key_type_cd','prod_nat_key_nr','prod_sid'),
	 ('xx','t_product_status','cbx','xx','prod_sid','prod_sid','xx','prod_nr','prod_nr','no','meta','meta','product','prod_key_type_cd','prod_nat_key_nr','prod_sid'),
	 ('xx','t_product','cbx','xx','prod_sid','prod_sid','xx','prod_nr','prod_nr','no','meta','meta','product','prod_key_type_cd','prod_nat_key_nr','prod_sid'),
	 ('xx','t_local_product_variant','cbx','xx','prod_sid','prod_sid','xx','local_prod_nr','local_prod_nr','no','meta','meta','product','prod_key_type_cd','prod_nat_key_nr','prod_sid'),
	 ('xx','t_local_product_variant','cbx','xx','int_org_sid','party_sid','xx','ctrcode','ctrcode','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid'),
	 ('xx','t_product_group','cbx','xx','prod_grp_sid','prod_grp_sid','xx','prod_grp_key_nr','prod_grp_key_nr','no','meta','meta','product_group','prod_grp_key_type_cd','prod_grp_nat_key_nr','prod_grp_sid'),
	 ('xx','t_product_to_product_group','cbx','xx','prod_sid','prod_sid','xx','prod_nr','prod_nr','no','meta','meta','product','prod_key_type_cd','prod_nat_key_nr','prod_sid'),
	 ('xx','t_product_to_product_group','cbx','xx','prod_grp_sid','prod_grp_sid','xx','prod_grp_nr','prod_grp_nr','no','meta','meta','product_group','prod_grp_key_type_cd','prod_grp_nat_key_nr','prod_grp_sid'),
	 ('xx','t_local_product','cbx','xx','prod_sid','prod_sid','xx','prod_nr','prod_nr','no','meta','meta','product','prod_key_type_cd','prod_nat_key_nr','prod_sid'),
	 ('xx','t_local_product','cbx','xx','int_org_sid','party_sid','xx','ctrcode','ctrcode','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid');
