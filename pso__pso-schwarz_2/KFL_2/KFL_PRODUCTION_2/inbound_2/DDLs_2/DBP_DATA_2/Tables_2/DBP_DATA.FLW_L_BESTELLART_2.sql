--==============================================================
-- Table: flw_l_bestellart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_bestellart_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_BESTELLART_2 (
   bestellart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Einkaufsbelegart aus bsart',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   bestell_typ_id                      VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Einkaufsbelegs aus bstyp. Z.Bsp. K für Kontrakte',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_BESTELLART PRIMARY KEY (bestellart_id, mandant_id, bestell_typ_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookuptabelle der Bestellarten aus t161t';

