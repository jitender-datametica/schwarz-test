create or replace TABLE KFL_PRODUCTION.DBP_DATA.MA_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0),
	MA_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Mitarbeiters. Wird im Beladeprozess als SK erzeugt aus den Feldern MANDT, IDNR, FUNCTION (Historisierung aufgrund CRDAT(Datum der Neuanlage des Datensatz)).',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
	MA_ANREDE VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'Anrede, z.Bsp. Herr, Frau',
	MA_NAME VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'Nachname des Mitarbeiters',
	MA_VORNAME VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'Nachname des Mitarbeiters',
	EMAIL VARCHAR(80) COLLATE 'en-ci' COMMENT 'Email Adresse',
	MOBIL_TEL VARCHAR(20) COLLATE 'en-ci' COMMENT 'Mobil Telefonnummer',
	MA_LDAP VARCHAR(10) COLLATE 'en-ci' COMMENT 'LDAP des Ma',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);