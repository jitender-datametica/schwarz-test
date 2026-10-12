create or replace TABLE KFL_PRODUCTION.DBP_DATA.ARTKZ_DISCOUNT_2 (
	DISCOUNT_ID NUMBER(38,0) NOT NULL COMMENT 'Schlüssel des Discount Artikelkennzeichens - numerischer Wert (0 = kein Discountartikel, oder Kennzeichen zwischen 1 und 7)',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache\n            ',
	DISCOUNT_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Bezeichnung des Discount -Artikelkennzeichens (z.Bsp. West, Nord und West, ...)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTKZ_DISCOUNT primary key (DISCOUNT_ID, MANDANT_ID)
)COMMENT='TP2_AIS - Artikelkennzeichen Discountartikel'
;