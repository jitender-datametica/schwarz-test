--==============================================================
-- Table: in_l_bestellart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_bestellart
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_L_BESTELLART (
   bestellart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Einkaufsbelegart aus bsart',
   mandant_id                          NUMBER(38,0)     NOT NULL,
   bestell_typ_id                      VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Einkaufsbelegs aus bstyp. Z.Bsp. K für Kontrakte',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_L_BESTELLART PRIMARY KEY (bestellart_id, mandant_id, bestell_typ_id) NOT ENFORCED
)  COMMENT = 'BIS- Lookuptabelle der Bestellarten aus t161t.';
