create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.GF (
	GF_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftsführer ID, numerisch',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	EK_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Kennzeichnet, ob es sich um einen dem Einkauf zugehörigen Mitarbeiter handelt',
	GF_NAME VARCHAR(160) COLLATE 'en-ci' COMMENT 'Name des Geschäftsführers',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='VIS - Lookup Tabelle  Geschäftsführer'
;
