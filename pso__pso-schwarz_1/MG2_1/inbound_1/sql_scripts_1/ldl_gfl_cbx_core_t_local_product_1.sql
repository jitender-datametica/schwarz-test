MERGE INTO ${CONFIGURATION_TABLE} tgt USING (SELECT 
 'xx' COUNTRY_1 ,
 't_local_product_1' TARGET_TABLE ,
 'cbx' SOURCE_SYSTEM ,
 'xx' SOURCE_UNIQUE_NAME ,
 'int_org_sid' SID_ALIAS ,
 'party_sid' SID_NAME ,
 'xx' TABLE_NAME ,
 'ctrcode' NATURAL_KEYS ,
 'ctrcode' TEMP_ALIAS_KEYS ,
 'no' ADD_TEMPORAL_JOIN ,
 'meta' LKP_TABLE_AREA ,
 'meta' KEYSPACE_SCHEMA ,
 'party' KEYSPACE_SUBJECT_AREA ,
 'party_key_type_cd' KEYSPACE_KEY_TYPE_CD ,
 'party_nat_key_nr' KEYSPACE_NATURAL_KEY_NAME ,
 'party_sid' KEYSPACE_SID_KEY_NAME  
 ) src 
ON tgt.country_1                   = src.country_1 AND tgt.target_table = src.target_table 
 AND tgt.source_system      = src.source_system
 AND tgt.source_unique_name = src.source_unique_name
 AND tgt.sid_alias          = src.sid_alias
 AND tgt.sid_name           = src.sid_name 
WHEN MATCHED THEN UPDATE SET table_name = src.table_name
, natural_keys              = src.natural_keys
, temp_alias_keys           = src.temp_alias_keys
, add_temporal_join         = src.add_temporal_join
, lkp_table_area            = src.lkp_table_area
, KEYSPACE_SCHEMA           = src.KEYSPACE_SCHEMA
, KEYSPACE_SUBJECT_AREA     = src.KEYSPACE_SUBJECT_AREA
, KEYSPACE_KEY_TYPE_CD      = src.KEYSPACE_KEY_TYPE_CD
, KEYSPACE_NATURAL_KEY_NAME = src.KEYSPACE_NATURAL_KEY_NAME
, KEYSPACE_SID_KEY_NAME     = src.KEYSPACE_SID_KEY_NAME 
WHEN NOT MATCHED THEN INSERT VALUES ( 
  src.country_1
, src.target_table
, src.source_system
, src.source_unique_name
, src.sid_alias
, src.sid_name
, src.table_name
, src.natural_keys
, src.temp_alias_keys
, src.add_temporal_join
, src.lkp_table_area
, src.KEYSPACE_SCHEMA
, src.KEYSPACE_SUBJECT_AREA
, src.KEYSPACE_KEY_TYPE_CD
, src.KEYSPACE_NATURAL_KEY_NAME
, src.KEYSPACE_SID_KEY_NAME);

MERGE INTO ${CONFIGURATION_TABLE} tgt USING (SELECT 
 'xx' COUNTRY_1 ,
 't_local_product_1' TARGET_TABLE ,
 'cbx' SOURCE_SYSTEM ,
 'xx' SOURCE_UNIQUE_NAME ,
 'prod_sid' SID_ALIAS ,
 'prod_sid' SID_NAME ,
 'xx' TABLE_NAME ,
 'prod_nr' NATURAL_KEYS ,
 'prod_nr' TEMP_ALIAS_KEYS ,
 'no' ADD_TEMPORAL_JOIN ,
 'meta' LKP_TABLE_AREA ,
 'meta' KEYSPACE_SCHEMA ,
 'product' KEYSPACE_SUBJECT_AREA ,
 'prod_key_type_cd' KEYSPACE_KEY_TYPE_CD ,
 'prod_nat_key_nr' KEYSPACE_NATURAL_KEY_NAME ,
 'prod_sid' KEYSPACE_SID_KEY_NAME  
 ) src 
ON tgt.country_1                   = src.country_1 AND tgt.target_table = src.target_table 
 AND tgt.source_system      = src.source_system
 AND tgt.source_unique_name = src.source_unique_name
 AND tgt.sid_alias          = src.sid_alias
 AND tgt.sid_name           = src.sid_name 
WHEN MATCHED THEN UPDATE SET table_name = src.table_name
, natural_keys              = src.natural_keys
, temp_alias_keys           = src.temp_alias_keys
, add_temporal_join         = src.add_temporal_join
, lkp_table_area            = src.lkp_table_area
, KEYSPACE_SCHEMA           = src.KEYSPACE_SCHEMA
, KEYSPACE_SUBJECT_AREA     = src.KEYSPACE_SUBJECT_AREA
, KEYSPACE_KEY_TYPE_CD      = src.KEYSPACE_KEY_TYPE_CD
, KEYSPACE_NATURAL_KEY_NAME = src.KEYSPACE_NATURAL_KEY_NAME
, KEYSPACE_SID_KEY_NAME     = src.KEYSPACE_SID_KEY_NAME 
WHEN NOT MATCHED THEN INSERT VALUES ( 
  src.country_1
, src.target_table
, src.source_system
, src.source_unique_name
, src.sid_alias
, src.sid_name
, src.table_name
, src.natural_keys
, src.temp_alias_keys
, src.add_temporal_join
, src.lkp_table_area
, src.KEYSPACE_SCHEMA
, src.KEYSPACE_SUBJECT_AREA
, src.KEYSPACE_KEY_TYPE_CD
, src.KEYSPACE_NATURAL_KEY_NAME
, src.KEYSPACE_SID_KEY_NAME);
