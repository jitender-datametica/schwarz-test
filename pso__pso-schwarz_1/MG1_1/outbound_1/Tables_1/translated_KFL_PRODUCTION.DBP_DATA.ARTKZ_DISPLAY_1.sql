CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTKZ_DISPLAY_1 (
DISPLAY_ID INTEGER NOT NULL OPTIONS(description='Schlüssel des Artikelkennzeichens Display (0 = kein Displayartikel'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache\n            '),
DISPLAY_BEZ STRING(80) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Artikelkennzeichens Display'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (DISPLAY_ID, MANDANT_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookup Artikelkennzeichen Display');