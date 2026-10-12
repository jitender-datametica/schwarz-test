create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.TS_ZB_PROJEKT_GEWERK_KOSTENART_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	BUCHUNG_TYP_CD VARCHAR(20) NOT NULL COMMENT 'Code gibt an ob es sich um eine_1 Buchung zu einer Bestellung (B), eine_1 Buchung zum Vertrag (V) oder um eine_1 Buchung ohne Bestellung und Vertrag (O) handelt.',
	KRK_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'globale ID des Kostenrechnungskreises',
	KOSTENART_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschluessel fuer die Kostenarten',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	ANMERKUNG_TXT VARCHAR(500) COMMENT 'Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk,, Kostenart_1',
	NICHT_RELEVANT_FG NUMBER(38,0) COMMENT 'Flag gibt an, ob der Datensatz für die Berechnung der Gesamtsummen relevant (0) ist oder nicht (1).',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_ZB_PROJEKT_GEWERK_KOSTENART primary key (MANDANT_ID, PROJEKT_NR, GEWERK_ID, BUCHUNG_TYP_CD, KRK_ID, KOSTENART_ID, GP_ID)
)COMMENT='TS-Tabelle auf Ebene Projekt, Gewerk und Kostenart_1  für zusätzliche Projektdaten aus den Zentralbereichen. Aktuell genutzt für Kennzahlen die sich nicht einer Bestellung oder einem Vertrag zuordnen lassen.'
;
