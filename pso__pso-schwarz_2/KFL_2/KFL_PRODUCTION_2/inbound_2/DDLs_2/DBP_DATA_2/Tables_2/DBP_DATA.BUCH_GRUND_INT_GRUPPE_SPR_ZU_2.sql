create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BUCH_GRUND_INT_GRUPPE_SPR_ZU_2 (
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
	BUCH_GRUND_INT_GRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'Gruppierungsmerkmal über interne Buchungsgründe',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
	BUCH_GRUND_INT_GRUPPE_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Bezeichnung der Gruppierung über interne Buchungsgründe',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BUCH_GRUND_INT_GRUPPE_SPR_ZU primary key (SYSTEM_ID, MANDANT_ID, BUCH_GRUND_INT_GRUPPE_ID, SPR_ID)
)COMMENT='RPW - DATA - Sprachtabhängige Bezeichnungen für die Gruppierung des internen Buchungsgrundes\n             '
;
