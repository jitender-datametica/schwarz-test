CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTKZ_VERPART_2 (
VERPART_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Verpackungsart, z.Bsp DS'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache.'),
VERPART_BEZ STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Sprachabhaengige Bezeichnung der Verpackungsart, z.Bsp. Dose'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, SPR_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle des Artikelkennzeichens Verpackungsart');