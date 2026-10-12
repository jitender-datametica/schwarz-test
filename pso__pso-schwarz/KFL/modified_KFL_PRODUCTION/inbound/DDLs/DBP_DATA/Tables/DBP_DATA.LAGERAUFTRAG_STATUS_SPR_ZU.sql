--==============================================================
-- Table: lagerauftrag_status_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerauftrag_status_spr_zu
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:58:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.LAGERAUFTRAG_STATUS_SPR_ZU (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              INTEGER    NOT NULL COMMENT 'ID der SpracheSprachschlüssel',
   lagerauftrag_status_id              VARCHAR(1)      NOT NULL COMMENT 'Lagerauftrag Status ID ',
   lagerauftrag_status_bez             VARCHAR(60)     COMMENT 'Lagersortiment Name'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lagerauftrag Status Bezeichnung';
