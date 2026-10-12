create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ARTKZ_EIGENMARKE (
	EIGENMARKE_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Eigenmarken-Kennzeichen (z.Bsp. C für Kaufland Klassikartikel)',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	EIGENMARKE_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Bezeichnung des Eigenmarkenkennzeichens',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTKZ_EIGENMARKE primary key (EIGENMARKE_ID, MANDANT_ID, SPR_ID)
)COMMENT='TP2_AIS - Lookuptabelle fuer Artikelkennzeichen  Eigenmarke'
;
