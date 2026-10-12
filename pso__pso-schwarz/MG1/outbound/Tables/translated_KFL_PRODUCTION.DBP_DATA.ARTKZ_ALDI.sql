CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTKZ_ALDI (
ALDI_ID INTEGER NOT NULL
OPTIONS(description='Kennzeichnet, in welcher/ welchen Vertriebsschiene(n) ein Artikel das Aldi Kennzeichen besitzt, kann sich auf eine oder mehrere Vertriebsschienen beziehen'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache\n            '),
ALDI_BEZ STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Artikelkennzeichens Aldi (z.Bsp, Nord, Nord und West, ...)'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ALDI_ID, MANDANT_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookup Tabelle fuer Artikelkennzeichen Aldi');