CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_spr_zu_1 (
mandant_id BIGNUMERIC(38,0),
ma_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mitarbeiters. Wird im Beladeprozess als SK erzeugt aus den Feldern MANDT, IDNR, FUNCTION (Historisierung aufgrund CRDAT(Datum der Neuanlage des Datensatz)).'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
ma_anrede STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Anrede, z.Bsp. Herr, Frau'),
ma_name STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Nachname des Mitarbeiters'),
ma_vorname STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Nachname des Mitarbeiters'),
email STRING(80) COLLATE 'und:ci' OPTIONS(description='Email Adresse'),
mobil_tel STRING(20) COLLATE 'und:ci' OPTIONS(description='Mobil Telefonnummer'),
ma_ldap STRING(10) COLLATE 'und:ci' OPTIONS(description='LDAP des Ma'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);