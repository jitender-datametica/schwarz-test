--==============================================================
-- Table: l_nachschub_option_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_nachschub_option_1
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:58:56
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_NACHSCHUB_OPTION_1 (
   MANDANT_ID                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   NACHSCHUB_OPTION_ID                 NUMBER(38,0)    NOT NULL COMMENT 'Nachschub Option ID'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Nachschub Option Lookup';
