--==============================================================
-- Table: in_bestellart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_bestellart_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_BESTELLART_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL,
   bestellart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Einkaufsbelegart aus bsart',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache im DWH',
   bestell_typ_id                      VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Einkaufsbelegs aus bstyp. Z.Bsp. K für Kontrakte',
   bestellart_bez                      VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Einkaufsbelegart aus batxt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_BESTELLART_SPR_ZU PRIMARY KEY (mandant_id, bestellart_id, spr_id, bestell_typ_id) NOT ENFORCED
)  COMMENT = 'BIS- Sprachabhängige Bezeichnung der Bestellarten aus t161t';
