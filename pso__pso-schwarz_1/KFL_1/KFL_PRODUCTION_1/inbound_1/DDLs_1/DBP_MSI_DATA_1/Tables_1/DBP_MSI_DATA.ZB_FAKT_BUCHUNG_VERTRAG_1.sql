create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.ZB_FAKT_BUCHUNG_VERTRAG_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	VERTRAG_NR VARCHAR(20) NOT NULL COMMENT 'Nummer des Vertrages.',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	WRG_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_VERTRAG NUMBER(38,5) COMMENT 'Betrag der Vertragswerte auf Ebene Projekt und Gewerk',
	BETRAG_OBLIGO NUMBER(38,5) COMMENT 'Betrag des Obligos auf Ebene Projekt und Gewerk.',
	BETRAG_BUCHUNG NUMBER(38,5) COMMENT 'Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_FAKT_BUCHUNG_VERTRAG primary key (MANDANT_ID, PROJEKT_NR, GEWERK_ID, VERTRAG_NR, GP_ID, WRG_TYP_ID)
)COMMENT='Faktentabelle für Buchungen die einem Vertrag zugeordnet werden können auf Ebene Projekt, Gewerk, Lieferant und Vertrag.'
;
