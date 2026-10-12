--==============================================================
-- Table: flw_bestellart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_bestellart_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_BESTELLART_SPR_ZU_1 (
   bestellart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Einkaufsbelegart aus bsart',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   bestell_typ_id                      VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Einkaufsbelegs aus bstyp. Z.Bsp. K für Kontrakte',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   bestellart_bez                      VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Einkaufsbelegart aus batxt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_BESTELLART_SPR_ZU PRIMARY KEY (bestellart_id, mandant_id, bestell_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnung der Bestellarten aus t161t. Durch den Systemsplitt IND-FLW wird diese Tabelle überflüssig';

