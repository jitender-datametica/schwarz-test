--==============================================================
-- Table: art_ipn_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_ipn_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_IPN_ZU (
   ipn_id                              INTEGER     NOT NULL COMMENT 'Internationale Produktnummer',
   gtin_id                             INTEGER     NOT NULL COMMENT 'Die Global Trade Item Number (GTIN) ist eine aus dem GS1-System (vormals EAN-System) stammende Identifikationsnummer, mit der Handelseinheiten ausgezeichnet werden können',
   gtin_typ_kz                         VARCHAR(2)       COLLATE 'en-ci' COMMENT 'Nummerntyp der GTIN(Global Trade Item Number)',
   loesch_fg                           INTEGER     COMMENT 'Löschvermerk',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_IPN_ZU PRIMARY KEY (ipn_id, gtin_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Zuordnungstabelle IPN (Internationale Produkt Nummer) zu GTIN';

