create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BUCH_GRUND_EXT_GRUPPE_ZU (
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
	BUCH_GRUND_EXT_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Schluessel fuer die externe Buchungsgründe der Rechnungen auf Kopf- und Positionsebene.',
	BUCH_GRUND_EXT_GRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'Gruppierungsmerkmal über externe Buchungsgründe',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BUCH_GRUND_EXT_GRUPPE_ZU primary key (SYSTEM_ID, MANDANT_ID, BUCH_GRUND_EXT_ID, BUCH_GRUND_EXT_GRUPPE_ID)
)COMMENT='RPW - DATA - Zuordnung der externen Buchungsgründe zur Buchungsgrundgruppe\n             '
;
