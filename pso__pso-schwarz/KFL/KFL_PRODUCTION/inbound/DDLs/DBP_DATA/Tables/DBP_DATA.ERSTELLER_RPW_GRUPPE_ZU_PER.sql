create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ERSTELLER_RPW_GRUPPE_ZU_PER (
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
	ERSTELLER_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutiger Schluessel fuer einen RPW User/Verursacher.',
	GRUPPE_ID VARCHAR(20) NOT NULL COMMENT 'Schluessel fuer eine Gruppe von RPW Usern. Zusammen mit einer Abteilung kann die Gruppe  eindeutig identifiziert werden.  ',
	ABTEILUNG_ID VARCHAR(20) NOT NULL COMMENT 'Eindeutiger Schluessel zur Indentifikaltion einer RPW Abteilung.',
	DAT_VON DATE NOT NULL COMMENT 'Gueltigkeitsbeginn der Zuordnung User zu Abteilung/Gruppe;',
	DAT_BIS DATE COMMENT 'Gueltigkeitsende der Zuordnung User zu Abteilung/Gruppe;',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ERSTELLER_RPW_GRUPPE_ZU_PER primary key (SYSTEM_ID, MANDANT_ID, ERSTELLER_ID, GRUPPE_ID, ABTEILUNG_ID, DAT_VON)
)COMMENT='RPW - Zeitabhaengige Zuordnung der RPW User/Verursacher zu einer Gruppe/Abteilung.'
;
