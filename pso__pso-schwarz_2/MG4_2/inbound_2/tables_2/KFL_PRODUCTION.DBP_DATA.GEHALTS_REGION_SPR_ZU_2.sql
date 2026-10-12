create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEHALTS_REGION_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	GEHALTS_REGION_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Gehaltsregion aus region_2',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
	GEHALTS_REGION_BEZ VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Gehaltsregion aus region_txt',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEHALTS_REGION_SPR_ZU primary key (MANDANT_ID, GEHALTS_REGION_ID, SPR_ID)
)COMMENT='SHR - Sprachabhängige Bezeichnung der Gehaltsregionen aus zhrregion'
;