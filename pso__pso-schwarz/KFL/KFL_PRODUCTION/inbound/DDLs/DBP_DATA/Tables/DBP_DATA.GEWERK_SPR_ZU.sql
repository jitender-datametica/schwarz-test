create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.GEWERK_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	GEWERK_ID NUMBER(38,0) NOT NULL COMMENT 'ID eines Gewerks , z.Bsp 3 = Baukosten',
	GEWERK_BEZ VARCHAR(200) NOT NULL COMMENT 'Sprachabhängige Bezeichnung der Gewerke',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEWERK_SPR_ZU primary key (MANDANT_ID, SPR_ID, GEWERK_ID)
)COMMENT='Tabelle für sprachabhängige Bezeichnungen der Gewerke.'
;
