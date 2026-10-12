--==============================================================
-- Table: l_oug_id
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_oug_id
   generated from Powerdesigner on Montag, 6. September 2021 14:06:27
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_OUG_ID (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   oug_id                              INTEGER    NOT NULL COMMENT 'Kennzeichen Obst und Gemüse'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'AIS - Lookup für das Kennzeichen Obst und Gemüse - SAP RET ZZEK_KZTGART_VAL';
