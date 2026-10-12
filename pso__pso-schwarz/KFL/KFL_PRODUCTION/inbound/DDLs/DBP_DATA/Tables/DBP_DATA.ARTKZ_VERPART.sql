create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ARTKZ_VERPART (
	VERPART_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Verpackungsart, z.Bsp DS',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache.',
	VERPART_BEZ VARCHAR(40) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Sprachabhaengige Bezeichnung der Verpackungsart, z.Bsp. Dose',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTKZ_VERPART primary key (VERPART_ID, MANDANT_ID, SPR_ID)
)COMMENT='TP2_AIS - Lookuptabelle des Artikelkennzeichens Verpackungsart'
;
