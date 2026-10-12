create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.TS_ZB_PROJEKT_GEWERK_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	WRG_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.',
	WRG_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_ZEK NUMBER(38,5) COMMENT 'Betrag der zu erwartenden Mehr- bzw. Minderkosten des Projektes auf Ebene Gewerk',
	ANMERKUNG_TXT VARCHAR(500) COMMENT 'Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_ZB_PROJEKT_GEWERK primary key (MANDANT_ID, PROJEKT_NR, GEWERK_ID, WRG_TYP_ID)
)COMMENT='TS-Tabelle auf Ebene Projekt und Gewerk für zusätzliche Projektdaten aus den Zentralbereichen'
;
