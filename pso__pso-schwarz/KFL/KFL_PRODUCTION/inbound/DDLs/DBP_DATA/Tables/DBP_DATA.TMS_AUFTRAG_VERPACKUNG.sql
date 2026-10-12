create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.TMS_AUFTRAG_VERPACKUNG (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_VERPACKUNG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Verpackung',
	TMS_VERPACKUNG_LFD_NR VARCHAR(10) NOT NULL COMMENT 'Identifier der Verpackung im Quellsystem',
	TMS_AUFTRAG_ID VARCHAR(30) NOT NULL COMMENT 'ID des Auftrags (Auftragsnummer). Aus plau.au_nr',
	TMS_AUFTRAG_UNTER_ID NUMBER(38,0) NOT NULL COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plau.au_unter_nr',
	TMS_TRANSPORTMITTEL_ID NUMBER(38,0) COMMENT 'ID des Transportmittels auf dem die Verpackung verpackt wird.',
	ANZ_VERPACKUNG NUMBER(38,0) COMMENT 'Anzahl gleichartiger Verpackungen',
	TMS_VERPACKUNG_BEM_TXT VARCHAR(30) COMMENT 'Freitext für Bemerkungen zur Verpackung.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TMS_AUFTRAG_VERPACKUNG primary key (MANDANT_ID, SYSTEM_ID, TMS_VERPACKUNG_ID)
)COMMENT='TMS - Die Tabelle enthält Verpackunsinformationen zum Auftrag inklusive des genutzen Transportmittels der Verpackung.'
;
