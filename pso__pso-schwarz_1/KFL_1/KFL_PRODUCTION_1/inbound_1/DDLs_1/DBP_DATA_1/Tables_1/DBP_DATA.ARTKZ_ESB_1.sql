create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ARTKZ_ESB_1 (
	ESB_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'ID des esb_Kennzeichens, z.Bsp. B',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache\n            ',
	ESB_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Bezeichnung des esb_Kennzeichens, z.Bsp. Blickpunktartikel',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTKZ_ESB primary key (ESB_ID, MANDANT_ID)
)COMMENT='TP2_AIS - Lookuptabelle des Kalkulationskennzeichens Nonfood'
;
