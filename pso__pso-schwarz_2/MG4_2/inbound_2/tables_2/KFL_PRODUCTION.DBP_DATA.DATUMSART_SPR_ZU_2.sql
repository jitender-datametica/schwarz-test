create or replace TABLE KFL_PRODUCTION.DBP_DATA.DATUMSART_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'PK - Mandant_2 im DWH',
	DATUMSART_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Datumsart, z.Bsp. 13',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
	DATUMSART_BEZ VARCHAR(50) COLLATE 'en-ci' COMMENT 'Bezeichnung der Datumsart, z.Bsp. Beginn Wehrdienst',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_DATUMSART_SPR_ZU primary key (MANDANT_ID, DATUMSART_ID, SPR_ID)
)COMMENT='SHR - Sprachabhängige Bezeichnung der Ereignisse'
;