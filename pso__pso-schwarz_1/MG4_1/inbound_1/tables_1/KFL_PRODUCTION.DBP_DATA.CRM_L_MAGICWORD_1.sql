create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_L_MAGICWORD_1 (
	CRM_MAGICWORD_ID VARCHAR(36) NOT NULL COMMENT 'Topic related to the content of the ticket which had been defined by the business',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_L_MAGICWORD primary key (CRM_MAGICWORD_ID)
)COMMENT='Lookup for magic word surrogate keys (= \"Zauberwort\" = topic category tag_1 for CRM tickets)'
;