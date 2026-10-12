create or replace TABLE KFL_PRODUCTION.DBP_DATA.AAD_REQUEST_TYPE_SPR_ZU (
	REQUEST_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'specifies the type of request, 1=Period extension,  2 =Decryption',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land.',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	REQUEST_TYPE_DESCR VARCHAR(255) COMMENT 'Describes the request typ, e.g. Period extension, Decryption',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AAD_REQUEST_TYPE_SPR_ZU primary key (MANDANT_ID, REQUEST_TYPE_ID, SPR_ID)
)COMMENT='Translations of descriptions of AAD Request Types'
;