--==============================================================
-- Table: flw_zerlege_gruppe_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_zerlege_gruppe_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ZERLEGE_GRUPPE_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   zerlege_gruppe_id                   INTEGER     NOT NULL COMMENT 'Zerlegegruppe aus zgrup.',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige Kennzeichnung der Sprache',
   zerlege_gruppe_bez                  VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Zerlegegruppe aus txt40, z.Bsp. R-Bug',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ZERLEGE_GRUPPE_SPR_ZU PRIMARY KEY (mandant_id, zerlege_gruppe_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Zerlege_Gruppen aus spmeat_tzgrpt';

