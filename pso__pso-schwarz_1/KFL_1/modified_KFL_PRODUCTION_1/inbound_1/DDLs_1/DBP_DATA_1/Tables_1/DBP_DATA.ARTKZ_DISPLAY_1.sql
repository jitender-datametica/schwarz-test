--==============================================================
-- Table: artkz_display_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_display_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTKZ_DISPLAY_1 (
   display_id                          INTEGER     NOT NULL COMMENT 'Schlüssel des Artikelkennzeichens Display (0 = kein Displayartikel',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   display_bez                         VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Artikelkennzeichens Display',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTKZ_DISPLAY PRIMARY KEY (display_id, mandant_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Lookup Artikelkennzeichen Display';

