create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ZB_PROJEKT_KONDITION_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	KONDITION_NR VARCHAR(50) NOT NULL COMMENT 'Nummer der Kondition',
	KONDITIONSTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutiger Fachschlüssel der Konditionsart.',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	MV_INTRENO VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'Interner Schlüssel des Mietvertrages',
	GP_ID NUMBER(38,0) COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	PARTNER_ID VARCHAR(10) COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Geschäftspartnernummer',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_KONDITION NUMBER(38,5) NOT NULL COMMENT 'Betrag der Kondition',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_PROJEKT_KONDITION primary key (MANDANT_ID, KONDITION_NR)
)COMMENT='Enthält Konditionen zu Verträgen die für ein Projekt gültig sind.'
;
