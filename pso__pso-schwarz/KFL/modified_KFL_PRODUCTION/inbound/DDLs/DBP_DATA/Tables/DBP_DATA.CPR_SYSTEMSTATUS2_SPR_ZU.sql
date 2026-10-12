--==============================================================
-- Table: cpr_systemstatus2_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_systemstatus2_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_SYSTEMSTATUS2_SPR_ZU (
   cpr_systemstatus2_id                INTEGER     NOT NULL COMMENT 'Schluessel für den Systemstatus2.  Enthält numerische Werte von 1 aufsteigend',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.',
   cpr_systemstatus2_bez               VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Systemstatus2',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_SYSTEMSTATUS2_SPR_ZU PRIMARY KEY (cpr_systemstatus2_id, spr_id) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Bezeichnungen zum Systemstatus2';

