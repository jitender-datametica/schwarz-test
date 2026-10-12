--==============================================================
-- Table: artkz_discount_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_discount_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artkz_discount_2 (
discount_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schlüssel des Discount Artikelkennzeichens - numerischer Wert (0 = kein Discountartikel, oder Kennzeichen zwischen 1 und 7)'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
discount_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Discount -Artikelkennzeichens (z.Bsp. West, Nord und West, ...)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (discount_id, mandant_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Artikelkennzeichen Discountartikel');