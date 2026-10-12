CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.MA_SPR_ZU (
MANDANT_ID INTEGER,
MA_ID INTEGER NOT NULL
OPTIONS(description='ID des Mitarbeiters. Wird im Beladeprozess als SK erzeugt aus den Feldern MANDT, IDNR, FUNCTION (Historisierung aufgrund CRDAT(Datum der Neuanlage des Datensatz)).'),
SPR_ID INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
MA_ANREDE STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Anrede, z.Bsp. Herr, Frau'),
MA_NAME STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Nachname des Mitarbeiters'),
MA_VORNAME STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Nachname des Mitarbeiters'),
EMAIL STRING(80) COLLATE 'und:ci' OPTIONS(description='Email Adresse'),
MOBIL_TEL STRING(20) COLLATE 'und:ci' OPTIONS(description='Mobil Telefonnummer'),
MA_LDAP STRING(10) COLLATE 'und:ci' OPTIONS(description='LDAP des Ma'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);