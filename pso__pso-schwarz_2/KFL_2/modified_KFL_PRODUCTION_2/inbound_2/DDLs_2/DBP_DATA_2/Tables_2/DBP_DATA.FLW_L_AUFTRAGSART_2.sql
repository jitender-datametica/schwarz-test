--==============================================================
-- Table: flw_l_auftragsart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_auftragsart_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_AUFTRAGSART_2 (
   auftragsart_id                      VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Auftragsart aus auart',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_AUFTRAGSART PRIMARY KEY (auftragsart_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookuptabelle der Auftragsarten aus t003p';

