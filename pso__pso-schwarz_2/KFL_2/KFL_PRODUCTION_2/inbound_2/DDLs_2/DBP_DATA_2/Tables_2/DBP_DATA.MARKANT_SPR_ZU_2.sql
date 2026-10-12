--==============================================================
-- Table: markant_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: markant_spr_zu_2
   generated from Powerdesigner on Donnerstag, 16. September 2021 11:42:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MARKANT_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   markant_id                          VARCHAR(2)      NOT NULL COMMENT 'ID Markantabrechnung',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'ID der Sprache',
   markant_bez                         VARCHAR(40)     COMMENT 'Bezeichnung Markantabrechnung'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'AIS - Sprachabhängige Bezeichnungen der Markantabrechnungen - manuelle Beladung';
