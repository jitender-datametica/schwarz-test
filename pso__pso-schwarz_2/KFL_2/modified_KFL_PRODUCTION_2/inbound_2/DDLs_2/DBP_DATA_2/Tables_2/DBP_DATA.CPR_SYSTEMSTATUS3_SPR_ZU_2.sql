--==============================================================
-- Table: cpr_systemstatus3_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_systemstatus3_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_SYSTEMSTATUS3_SPR_ZU_2 (
   cpr_systemstatus3_id                INTEGER     NOT NULL COMMENT 'Schluessel für den Systemstatus3.  Enthält numerische Werte von 1 aufsteigend',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.',
   cpr_systemstatus3_bez               VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Systemstatus3',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_SYSTEMSTATUS3_SPR_ZU PRIMARY KEY (cpr_systemstatus3_id, spr_id) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Bezeichnungen zum Systemstatus3';

