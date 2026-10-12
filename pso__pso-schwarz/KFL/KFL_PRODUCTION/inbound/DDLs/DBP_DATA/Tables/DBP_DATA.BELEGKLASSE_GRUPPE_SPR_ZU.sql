create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BELEGKLASSE_GRUPPE_SPR_ZU (
	BELEGKLASSE_GRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Belegklasse - Gruppe',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
	BELEGKLASSE_GRUPPE_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'sprachabhaengige Bezeichnung fuer die Belegklasse -Gruppe.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BELEGKLASSE_GRUPPE_SPR_ZU primary key (BELEGKLASSE_GRUPPE_ID, MANDANT_ID, SYSTEM_ID, SPR_ID)
)COMMENT='Sprachabhängige Bezeichnung der Belegklassen Gruppierung'
;
