--==============================================================
-- Table: l_nachschub_option_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_nachschub_option_2
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:58:56
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_NACHSCHUB_OPTION_2 (
   MANDANT_ID                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   NACHSCHUB_OPTION_ID                 INTEGER    NOT NULL COMMENT 'Nachschub Option ID'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Nachschub Option Lookup';
