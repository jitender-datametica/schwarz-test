create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.TS_ZB_PROJEKT_GEWERK_VERTRAG_PARTNER (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	VERTRAG_NR VARCHAR(20) NOT NULL COMMENT 'Nummer des Vertrages.',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	ANMERKUNG_TXT VARCHAR(500) COMMENT 'Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk, Warengruppe, Kostenart',
	NICHT_RELEVANT_FG NUMBER(38,0) COMMENT 'Flag gibt an, ob der Datensatz für die Berechnung der Gesamtsummen relevant (0) ist oder nicht (1).',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_ZB_PROJEKT_GEWERK_VERTRAG_PARTNER primary key (MANDANT_ID, PROJEKT_NR, GEWERK_ID, VERTRAG_NR, GP_ID)
)COMMENT='TS-Tabelle auf Ebene Projekt, Gewerk, Vertrag und Partner / Lieferant für zusätzliche Projektdaten aus den Zentralbereichen. Aktuell genutzt für Kennzahlen die sich einem Vertrag zuordnen lassen.'
;
