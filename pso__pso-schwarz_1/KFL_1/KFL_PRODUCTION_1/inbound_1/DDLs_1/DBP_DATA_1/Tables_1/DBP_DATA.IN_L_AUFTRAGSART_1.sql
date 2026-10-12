--==============================================================
-- Table: in_l_auftragsart_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_auftragsart_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_L_AUFTRAGSART_1 (
   auftragsart_id                      VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Auftragsart aus auart',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_L_AUFTRAGSART PRIMARY KEY (auftragsart_id, mandant_id) NOT ENFORCED
)  COMMENT = 'IMS - Lookuptabelle der Auftragsarten aus t003p';
