--==============================================================
-- Table: flw_l_auftragsart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_auftragsart
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_AUFTRAGSART (
   auftragsart_id                      VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Auftragsart aus auart',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_AUFTRAGSART PRIMARY KEY (auftragsart_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookuptabelle der Auftragsarten aus t003p';

