create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ABTEILUNG_RPW_SPR_ZU_2 (
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
	ABTEILUNG_ID VARCHAR(20) NOT NULL COMMENT 'Eindeutiger Fachschluessel zur Referenzierung einer Abteilung aus der DWH Tabelle l_abteilung_rpw.',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1;',
	ABTEILUNG_RPW_BEZ VARCHAR(40) COMMENT 'Sprachabhaengige Bezeichnung fuer die RPW Abteillung. Es wird fuer jede DWH Sprache = 1 ein Eintrag erstellt.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ABTEILUNG_RPW_SPR_ZU primary key (SYSTEM_ID, MANDANT_ID, ABTEILUNG_ID, SPR_ID)
)COMMENT='RPW - Sprachabhaengige Bezeichnung der RPW Abteilungen. Es wird fuer jede DWH Sprache = 1 ein Eintrag hinterlegt. Defaultwert ist die deutsche Bezeichnung.'
;
