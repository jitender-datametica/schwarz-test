CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTKZ_ESB_2 (
ESB_ID STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des esb_Kennzeichens, z.Bsp. B'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache\n            '),
ESB_BEZ STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des esb_Kennzeichens, z.Bsp. Blickpunktartikel'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle des Kalkulationskennzeichens Nonfood');