create or replace TABLE KFL_PRODUCTION.DBP_DATA.HAUS_KATEGORIE_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	HAUS_KATEGORIE_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Hauskategorie aus house_cat',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
	HAUS_KATEGORIE_BEZ VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Hauskategorie aus house_cat_txt',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_HAUS_KATEGORIE_SPR_ZU primary key (MANDANT_ID, HAUS_KATEGORIE_ID, SPR_ID)
)COMMENT='SHR - Sprachabhängige Bezeichnung der Hauskategorie aus zhrhousecat'
;