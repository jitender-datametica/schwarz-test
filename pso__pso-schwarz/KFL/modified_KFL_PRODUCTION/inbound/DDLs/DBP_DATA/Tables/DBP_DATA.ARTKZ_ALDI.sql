--==============================================================
-- Table: artkz_aldi
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_aldi
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTKZ_ALDI (
   aldi_id                             INTEGER     NOT NULL COMMENT 'Kennzeichnet, in welcher/ welchen Vertriebsschiene(n) ein Artikel das Aldi Kennzeichen besitzt, kann sich auf eine oder mehrere Vertriebsschienen beziehen',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   aldi_bez                            VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Artikelkennzeichens Aldi (z.Bsp, Nord, Nord und West, ...)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTKZ_ALDI PRIMARY KEY (aldi_id, mandant_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Lookup Tabelle fuer Artikelkennzeichen Aldi';

