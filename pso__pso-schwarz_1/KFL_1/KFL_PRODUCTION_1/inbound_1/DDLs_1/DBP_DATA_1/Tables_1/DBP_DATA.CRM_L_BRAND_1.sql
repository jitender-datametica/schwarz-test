create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_L_BRAND_1 (
	CRM_BRAND_ID VARCHAR(36) NOT NULL COMMENT 'ID of brand_1 the customer has a complain abou',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_L_BRAND primary key (CRM_BRAND_ID)
)COMMENT='Lookup for brand_1 surrogate keys (= brand_1 the customer has a complain about)'
;
