--==============================================================
-- Table: l_lagerauftrag_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lagerauftrag_status_1
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:58:09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_LAGERAUFTRAG_STATUS_1 (
   MANDANT_ID                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   LAGERAUFTRAG_STATUS_ID              VARCHAR(1)      NOT NULL COMMENT 'Lagerauftrag_1 Status_1 ID '
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lagerauftrag_1 Status_1 Lookup';
