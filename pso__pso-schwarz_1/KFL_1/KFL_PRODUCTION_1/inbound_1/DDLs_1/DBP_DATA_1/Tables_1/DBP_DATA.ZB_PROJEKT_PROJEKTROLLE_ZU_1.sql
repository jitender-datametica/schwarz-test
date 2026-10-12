create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ZB_PROJEKT_PROJEKTROLLE_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Nummer des Projektes aus ePPM. ',
	PROJEKTROLLE_CD VARCHAR(100) NOT NULL COMMENT 'Eindeutiger Code der Projektrolle.',
	MITARBEITER_NAME VARCHAR(100) NOT NULL COMMENT 'Name des Mitarbeiters der zum aktuellen Zeitpunkt die Rolle innerhalb des Projektes ausübt.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_PROJEKT_PROJEKTROLLE_ZU primary key (MANDANT_ID, PROJEKT_NR, PROJEKTROLLE_CD)
)COMMENT='Zuordnungstabelle zwischen einem  Projekt aus den Zentralbereichen und alle darin ausgeübten Projektrollen.'
;
