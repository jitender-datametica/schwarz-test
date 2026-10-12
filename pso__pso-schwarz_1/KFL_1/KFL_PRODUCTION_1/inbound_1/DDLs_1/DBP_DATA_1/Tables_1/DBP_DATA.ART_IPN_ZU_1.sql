--==============================================================
-- Table: art_ipn_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_ipn_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_IPN_ZU_1 (
   ipn_id                              NUMBER(18,0)     NOT NULL COMMENT 'Internationale Produktnummer',
   gtin_id                             NUMBER(26,0)     NOT NULL COMMENT 'Die Global Trade Item_1 Number (GTIN) ist eine_1 aus dem GS1-System (vormals EAN_1-System) stammende Identifikationsnummer, mit der Handelseinheiten ausgezeichnet werden können',
   gtin_typ_kz                         VARCHAR(2)       COLLATE 'en-ci' COMMENT 'Nummerntyp der GTIN(Global Trade Item_1 Number)',
   loesch_fg                           NUMBER(38,0)     COMMENT 'Löschvermerk',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_IPN_ZU PRIMARY KEY (ipn_id, gtin_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Zuordnungstabelle IPN_1 (Internationale Produkt Nummer) zu GTIN';

