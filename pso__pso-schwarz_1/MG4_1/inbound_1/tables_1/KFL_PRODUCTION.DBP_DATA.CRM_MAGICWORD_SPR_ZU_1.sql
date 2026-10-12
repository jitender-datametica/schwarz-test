create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_MAGICWORD_SPR_ZU_1 (
	CRM_MAGICWORD_ID VARCHAR(36) NOT NULL COMMENT 'Topic related to the content of the ticket which had been defined by the business',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'country_1 ID',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'language ID',
	CRM_MAGICWORD_BEZ VARCHAR(100) COMMENT 'description of the magic word',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_MAGICWORD_SPR_ZU primary key (CRM_MAGICWORD_ID, MANDANT_ID, SPR_ID)
)COMMENT='Spr_zu für magic word surrogate keys (= \"Zauberwort\" = topic category tag_1 for CRM tickets)'
;