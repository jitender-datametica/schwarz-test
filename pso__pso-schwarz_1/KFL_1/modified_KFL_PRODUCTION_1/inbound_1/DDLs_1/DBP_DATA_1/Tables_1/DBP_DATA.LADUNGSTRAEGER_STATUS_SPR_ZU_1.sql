--==============================================================
-- Table: ladungstraeger_status_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ladungstraeger_status_spr_zu_1
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 07:40:03
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.LADUNGSTRAEGER_STATUS_SPR_ZU_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              INTEGER    NOT NULL COMMENT 'Sprachschlüssel',
   ladungstraeger_status_id            VARCHAR(2)      NOT NULL COMMENT 'Ladungsträger Status_1 ID     ',
   ladungstraeger_status_bez           VARCHAR(60)     COMMENT 'Ladungsträger Status_1 Bezeichnung   ',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Ladungsträger Status_1 Bezeichnung';
