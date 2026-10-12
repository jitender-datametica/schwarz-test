--==============================================================
-- Table: l_lagerauftrag_status_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lagerauftrag_status_2
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:58:09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_LAGERAUFTRAG_STATUS_2 (
   MANDANT_ID                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   LAGERAUFTRAG_STATUS_ID              VARCHAR(1)      NOT NULL COMMENT 'Lagerauftrag_2 Status_2 ID '
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lagerauftrag_2 Status_2 Lookup';
