create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.ZB_FAKT_PROJEKT_GEWERK_KOSTENART_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	BUCHUNG_TYP_CD VARCHAR(20) NOT NULL COMMENT 'Code gibt an ob es sich um eine_1 Buchung zu einer Bestellung (B), eine_1 Buchung zum Vertrag (V) oder um eine_1 Buchung ohne Bestellung und Vertrag (O) handelt.',
	KRK_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'globale ID des Kostenrechnungskreises',
	KOSTENART_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschluessel fuer die Kostenarten',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	WRG_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_BUCHUNG NUMBER(38,5) COMMENT 'Betrag der Buchungen der Rechnungen auf Ebene Projekt,Gewerk und Kostenart_1',
	BETRAG_RUECKSTELLUNG NUMBER(38,5) COMMENT 'Betrag der als Rückstellungen identifizierte Buchungen auf Ebene Projekt Gewerk und Kostenart_1',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_FAKT_PROJEKT_GEWERK_KOSTENART primary key (MANDANT_ID, PROJEKT_NR, GEWERK_ID, KRK_ID, KOSTENART_ID, BUCHUNG_TYP_CD, GP_ID, WRG_TYP_ID)
)COMMENT='Faktentabelle auf Ebene Projekt, Gewerk, Warengruppe und Kostenart_1  für Projektdaten aus den Zentralbereichen. Aktuell genutzt für Kennzahlen die sich nicht einer Bestellung oder einem Vertrag zuordnen lassen.'
;
