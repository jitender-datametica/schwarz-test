--==============================================================
-- Table: in_auftragsart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_auftragsart_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_AUFTRAGSART_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   auftragsart_id                      VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Auftragsart aus auart',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   auftragsart_bez                     VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Auftragsart aus txt',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_AUFTRAGSART_SPR_ZU PRIMARY KEY (mandant_id, auftragsart_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMS - Sprachabhängige Bezeichnung der Auftragsarten aus t003p';
