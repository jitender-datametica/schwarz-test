--==============================================================
-- Table: flw_l_fehlgrund_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_fehlgrund_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_FEHLGRUND_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID der Mandanten im DWH; Deutschland entspricht Mandant_ID = 1',
   fehlgrund_id                        VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Fehl- / Verspätungsgrundes aus txt  - wird aus Modellierungsgründen zur ID erklärt',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   fehlgrund_bez                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Attribut  des Fehl- / Verspätungsgrundes aus art_2 - scheint sich um den Verursacher zu handeln',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_FEHLGRUND PRIMARY KEY (mandant_id, fehlgrund_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookuptabelle zur Verwaltung von Fehl/Verspätungsgründen aus zfw_mympfgrund
             ';

