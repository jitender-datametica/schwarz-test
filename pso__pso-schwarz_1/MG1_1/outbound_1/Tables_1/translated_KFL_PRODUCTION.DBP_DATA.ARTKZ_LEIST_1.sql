CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTKZ_LEIST_1 (
LEIST_ID STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Artikelkennzeichen Leistungsstark Food'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache\n            '),
LEIST_BEZ STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Leistungsstärke Food Bezeichnung.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle des Artikelkennzeichens leistungsstark');