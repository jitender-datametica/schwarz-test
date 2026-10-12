CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTKZ_POSTEN_1 (
POSTEN_ID STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache.'),
POSTEN_BEZ STRING(40) COLLATE 'und:ci' OPTIONS(description='Sprachabhaengige Bezeichnung des Postenkennzeichens.'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, SPR_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle fuer das Artikelkennzeichen Postenartikel');