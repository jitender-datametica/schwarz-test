create or replace TABLE KFL_PRODUCTION.DBP_DATA.AAD_REQUEST_REASON_TYPE_SPR_ZU_2 (
	REQUEST_REASON_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the the reason code',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH - ein Mandant_2 pro Land.',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	REQUEST_REASON_TYPE_DESCR VARCHAR(255) COMMENT 'Describes the reason codes',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AAD_REQUEST_REASON_TYPE_SPR_ZU primary key (MANDANT_ID, REQUEST_REASON_TYPE_ID, SPR_ID)
)COMMENT='Translations of descriptions of AAD Request creation reason codes'
;