--==============================================================
-- Table: bestellart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bestellart_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESTELLART_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   bestellart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   bestellart_bez                      VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Dieses Attribut enthält die Kurztexte der Bestellarten.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESTELLART_SPR_ZU PRIMARY KEY (mandant_id, bestellart_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle sind die sprachabhängigen Kurztexte für die Arten der Bestellungen enthalten - MULTISET.';

