create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.TMS_RECHNUNG_DET_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_RECH_BELEG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Rechnung (Rechnungsnummer). Aus plrpos.beleg_nr',
	TMS_RECH_BELEG_POS_ID VARCHAR(8) NOT NULL COMMENT 'Rechnungspositionsnummer. Aus plrpos.beleg_posnr',
	TMS_RECH_BEZUG_LFD_NR NUMBER(38,0) NOT NULL COMMENT 'ID der Zuordnung / Referenz im Quellsystem.',
	BEZUGSART_ID NUMBER(38,0) COMMENT 'ID der Art_1 des Belegbezugs: 0 = undefiniert; 1 = Tour_1; 2 = Tourposition; 3 = Auftrag; 4 = Auftragsposition; 5 = HAU / Gesamtauftrag; 6 = Tag_1; 7 = E_Bordero; 8 = Teil transport; 9 = Gesamtrechnung; 10 = Teil Transport E Bordero; 100 = TRM',
	BEZUG_SCHLUESSEL_NR VARCHAR(30) COMMENT 'Gesamter Schluessel des Bezugsbelegs.',
	TMS_REF_NR VARCHAR(30) COMMENT 'Erster Teil des Bezugsbelegs, bspw. Auftrag',
	TMS_REF_UNTER_NR VARCHAR(30) COMMENT 'Zweiter Teil des Bezugsbelegs, bspw. Unterauftrag',
	TMS_REF_POS_NR VARCHAR(30) COMMENT 'Dritter Teil des Bezugsbelegs, bspw. Auftragsposition',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TMS_RECHNUNG_DET_ZU primary key (MANDANT_ID, SYSTEM_ID, TMS_RECH_BELEG_ID, TMS_RECH_BELEG_POS_ID, TMS_RECH_BEZUG_LFD_NR)
)COMMENT='TMS - Zuordnungstabelle zwischen den Rechnungspositionen und je nach Bezugsart anderen Belegen wie bspw. Auftragspositionen, Tourenpositionen, Gesamtrechnungen, etc.'
;
