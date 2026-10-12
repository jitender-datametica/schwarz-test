--==============================================================
-- Table: l_lagerauftrag_status
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lagerauftrag_status
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:58:09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_LAGERAUFTRAG_STATUS (
   MANDANT_ID                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   LAGERAUFTRAG_STATUS_ID              VARCHAR(1)      NOT NULL COMMENT 'Lagerauftrag Status ID '
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lagerauftrag Status Lookup';
