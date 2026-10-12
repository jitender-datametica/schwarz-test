--==============================================================
-- Table: l_ladungstraeger_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ladungstraeger_status_1
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 07:41:56
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_LADUNGSTRAEGER_STATUS_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   ladungstraeger_status_id            VARCHAR(2)      NOT NULL COMMENT 'Ladungsträger Status_1 ID     ',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Ladungsträger Status_1 Lookup';