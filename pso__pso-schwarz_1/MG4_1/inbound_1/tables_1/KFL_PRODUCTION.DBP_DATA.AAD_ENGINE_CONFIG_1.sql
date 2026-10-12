create or replace TABLE KFL_PRODUCTION.DBP_DATA.AAD_ENGINE_CONFIG_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
	CONFIG_ID NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the config setting',
	CONFIG_VAL NUMBER(38,0) NOT NULL COMMENT 'Value of the config setting',
	CONFIG_DESCR VARCHAR(255) COMMENT 'Describes the meaning of the config parameter in English',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AAD_ENGINE_CONFIG primary key (MANDANT_ID, CONFIG_ID)
)COMMENT='Contains configuration that the fraud detection model uses when processing data.'
;