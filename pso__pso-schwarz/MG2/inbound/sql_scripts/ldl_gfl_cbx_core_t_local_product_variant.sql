create or replace TABLE T_TCACHE_T215_INT_ITEMNR (
	CTRCODE VARCHAR(3) NOT NULL COLLATE 'en-ci',
	C215_INT_ITEMNR VARCHAR(20) NOT NULL,
	C215_ITEMNR VARCHAR(18) NOT NULL,
	C215_INT_ITEMDESC VARCHAR(100),
	C215_CASESIZE NUMBER(10,5),
	C215_MODDATE TIMESTAMP_NTZ(9),
	C215_MODUSER VARCHAR(8),
	C215_INT_ITEMNRSHO VARCHAR(4),
	C215_ACTIVE NUMBER(5,0),
	C215_IS_MAIN_LINK NUMBER(1,0),
	SCN NUMBER(38,0) DEFAULT 0,
	EXTRACTION_TMSP TIMESTAMP_NTZ(9),
	EXTRACTION_DT DATE,
	DWH_CREATED_TMSP TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED_TMSP TIMESTAMP_NTZ(9) NOT NULL,
	DWH_LOAD_ID NUMBER(38,0) NOT NULL,
	DWH_NODE_CD VARCHAR(20) NOT NULL
);

MERGE INTO ETL_PROCESS.t_etl_pset_responsible tgt 
USING (
SELECT 
   'ldl' AS DIVISION
 , 'ldl_gfl_cbx_core' AS PROJECT
 , 'LDL_GFL_CBX_CORE' AS APPLICATION
 , 'cbx-data' AS SYSTEM_GROUP
 , 't215_int_itemnr' AS INTERFACE
 , 'xx_upsert_unhist_t215_int_itemnr_2_tcache_t215_int_itemnr' AS PSET
 , 'rene.pereira_ext@mail.schwarz' AS EMAIL_DEVELOPER
 , 'petar.katsarov@mail.schwarz' AS EMAIL_TEAM_LEAD
 , 'danijel.jelic@mail.schwarz' AS EMAIL_BSE
 ,  CURRENT_DATE                            AS LAST_REJECT_AT
 ,  CURRENT_DATE                            AS DWH_CREATED_TMSP
 ) src 
ON TRUE
 AND tgt.division  = src.division 
 AND tgt.project   = src.project 
 AND tgt.pset      = src.pset
WHEN MATCHED THEN UPDATE 
SET 
  APPLICATION      = SRC.APPLICATION
, SYSTEM_GROUP     = SRC.SYSTEM_GROUP
, INTERFACE        = SRC.INTERFACE
, EMAIL_DEVELOPER  = SRC.EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD  = SRC.EMAIL_TEAM_LEAD
, EMAIL_BSE        = SRC.EMAIL_BSE
, LAST_REJECT_AT   = SRC.LAST_REJECT_AT
, DWH_CREATED_TMSP = SRC.DWH_CREATED_TMSP
WHEN NOT MATCHED THEN INSERT VALUES ( 
  DIVISION
, PROJECT
, APPLICATION
, SYSTEM_GROUP
, INTERFACE
, PSET
, EMAIL_DEVELOPER
, EMAIL_TEAM_LEAD
, EMAIL_BSE
, LAST_REJECT_AT
, DWH_CREATED_TMSP
)
;



MERGE INTO ${CONFIGURATION_TABLE} tgt USING (SELECT 
 'xx' COUNTRY ,
 't_local_product_variant' TARGET_TABLE ,
 'cbx' SOURCE_SYSTEM ,
 'xx' SOURCE_UNIQUE_NAME ,
 'prod_variant_sid' SID_ALIAS ,
 'prod_variant_sid' SID_NAME ,
 'xx' TABLE_NAME ,
 'local_prod_variant_nr' NATURAL_KEYS ,
 'local_prod_variant_nr' TEMP_ALIAS_KEYS ,
 'no' ADD_TEMPORAL_JOIN ,
 'meta' LKP_TABLE_AREA ,
 'meta' KEYSPACE_SCHEMA ,
 'product_variant' KEYSPACE_SUBJECT_AREA ,
 'prod_variant_key_type_cd' KEYSPACE_KEY_TYPE_CD ,
 'prod_variant_nat_key_nr' KEYSPACE_NATURAL_KEY_NAME ,
 'prod_variant_sid' KEYSPACE_SID_KEY_NAME  
 ) src 
ON tgt.country                   = src.country AND tgt.target_table = src.target_table 
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
  src.country
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
 'xx' COUNTRY ,
 't_local_product_variant' TARGET_TABLE ,
 'cbx' SOURCE_SYSTEM ,
 'xx' SOURCE_UNIQUE_NAME ,
 'prod_sid' SID_ALIAS ,
 'prod_sid' SID_NAME ,
 'xx' TABLE_NAME ,
 'local_prod_nr' NATURAL_KEYS ,
 'local_prod_nr' TEMP_ALIAS_KEYS ,
 'no' ADD_TEMPORAL_JOIN ,
 'meta' LKP_TABLE_AREA ,
 'meta' KEYSPACE_SCHEMA ,
 'product' KEYSPACE_SUBJECT_AREA ,
 'prod_key_type_cd' KEYSPACE_KEY_TYPE_CD ,
 'prod_nat_key_nr' KEYSPACE_NATURAL_KEY_NAME ,
 'prod_sid' KEYSPACE_SID_KEY_NAME  
 ) src 
ON tgt.country                   = src.country AND tgt.target_table = src.target_table 
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
  src.country
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
 'xx' COUNTRY ,
 't_local_product_variant' TARGET_TABLE ,
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
ON tgt.country                   = src.country AND tgt.target_table = src.target_table 
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
  src.country
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
