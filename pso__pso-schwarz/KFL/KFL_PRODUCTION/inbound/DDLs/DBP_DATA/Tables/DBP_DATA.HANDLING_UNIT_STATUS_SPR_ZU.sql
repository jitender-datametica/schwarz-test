--==============================================================
-- Table: handling_unit_status_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: handling_unit_status_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HANDLING_UNIT_STATUS_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   hu_status_id                        VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID Bewegungsstatus der Handling Unit',
   hu_status_bez                       VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung Bewegungsstatus der Handling Unit',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_HANDLING_UNIT_STATUS_SPR_ZU PRIMARY KEY (mandant_id, spr_id, hu_status_id) NOT ENFORCED
)  COMMENT = 'LIS - Sprachtabelle Bewegungsstautus Handling Unit';
