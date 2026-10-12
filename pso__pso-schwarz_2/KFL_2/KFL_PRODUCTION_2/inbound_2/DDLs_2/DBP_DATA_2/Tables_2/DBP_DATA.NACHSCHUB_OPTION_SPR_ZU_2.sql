--==============================================================
-- Table: nachschub_option_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nachschub_option_spr_zu_2
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:59:29
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.NACHSCHUB_OPTION_SPR_ZU_2 (
   MANDANT_ID                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   SPR_ID                              NUMBER(38,0)    NOT NULL COMMENT 'ID der Sprache SPRACHSCHLÜSSEL',
   NACHSCHUB_OPTION_ID                 NUMBER(38,0)    NOT NULL COMMENT 'Nachschub Option ID',
   NACHSCHUB_OPTION_BEZ                VARCHAR(60)     COMMENT 'Nachschub Option Bezeichnung'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Nachschub Option Bezeichnung';
