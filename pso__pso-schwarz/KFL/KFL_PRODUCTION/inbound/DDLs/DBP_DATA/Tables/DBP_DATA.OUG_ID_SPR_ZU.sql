--==============================================================
-- Table: oug_id_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: oug_id_spr_zu
   generated from Powerdesigner on Montag, 6. September 2021 14:09:12
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.OUG_ID_SPR_ZU (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   oug_id                              NUMBER(38,0)    NOT NULL COMMENT 'Kennzeichen Obst und Gemüse',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'Sprachschlüssel',
   oug_id_bez                       VARCHAR(40)     NOT NULL COMMENT 'Bezeichnung für Kennzeichen Obst und Gemüse',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'AIS - Sprachabhängige Bezeichnungen für das Kennzeichen Obst und Gemüse - SAP RET ZZEK_KZTGART_LAN';
