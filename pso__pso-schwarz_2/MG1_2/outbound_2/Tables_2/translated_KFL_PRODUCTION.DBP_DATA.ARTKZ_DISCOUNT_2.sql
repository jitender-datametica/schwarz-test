CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTKZ_DISCOUNT_2 (
DISCOUNT_ID INTEGER NOT NULL
OPTIONS(description='Schlüssel des Discount Artikelkennzeichens - numerischer Wert (0 = kein Discountartikel, oder Kennzeichen zwischen 1 und 7)'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache\n            '),
DISCOUNT_BEZ STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Discount -Artikelkennzeichens (z.Bsp. West, Nord und West, ...)'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (DISCOUNT_ID, MANDANT_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Artikelkennzeichen Discountartikel');