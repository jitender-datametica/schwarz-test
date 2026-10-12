--==============================================================
-- Table: artkz_discount_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_discount_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTKZ_DISCOUNT_2 (
   discount_id                         INTEGER     NOT NULL COMMENT 'Schlüssel des Discount Artikelkennzeichens - numerischer Wert (0 = kein Discountartikel, oder Kennzeichen zwischen 1 und 7)',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   discount_bez                        VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Discount -Artikelkennzeichens (z.Bsp. West, Nord und West, ...)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTKZ_DISCOUNT PRIMARY KEY (discount_id, mandant_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Artikelkennzeichen Discountartikel';

