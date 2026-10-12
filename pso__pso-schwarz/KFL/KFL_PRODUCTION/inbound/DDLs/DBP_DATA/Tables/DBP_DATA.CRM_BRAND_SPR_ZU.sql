create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_BRAND_SPR_ZU (
	CRM_BRAND_ID VARCHAR(36) NOT NULL COMMENT 'ID of brand the customer has a complain abou',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'country ID',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'language ID',
	CRM_BRAND_BEZ VARCHAR(100) COMMENT 'description of the brand',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_BRAND_SPR_ZU primary key (CRM_BRAND_ID, MANDANT_ID, SPR_ID)
)COMMENT='Spr_zu for brand surrogate keys (= brand the customer has a complain about)'
;
