--==============================================================
-- Table: cpr_systemstatus1_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_systemstatus1_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_SYSTEMSTATUS1_SPR_ZU_1 (
   cpr_systemstatus1_id                NUMBER(38,0)     NOT NULL COMMENT 'Schluessel für den Systemstatus1, Enthält numerische Werte von 1 aufsteigend',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
   cpr_systemstatus1_bez               VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Systemstatus1',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_SYSTEMSTATUS1_SPR_ZU PRIMARY KEY (cpr_systemstatus1_id, spr_id) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Bezeichnungen zum Systemstatus1';

