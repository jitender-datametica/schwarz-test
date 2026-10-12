--==============================================================
-- Table: flw_tiergattung_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_tiergattung_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_TIERGATTUNG_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   tiergattung_id                      INTEGER     NOT NULL COMMENT 'Eindeutige ID der Tiergattung, z.Bsp 1 = Schwein aus tgtky',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   tiergattung_bez                     VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Tiergattung (Schwein, Rind,..) aus txt40',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_TIERGATTUNG_SPR_ZU PRIMARY KEY (mandant_id, tiergattung_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnung der Tiergattung aus spmeat_tmtgt';

