--==============================================================
-- Table: flw_kalk_plan_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_plan_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_KALK_PLAN_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   plan_kalk_id                        INTEGER     NOT NULL COMMENT 'Eindeutige ID der Plankalkulation aus clpnr',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   plan_kalk_bez                       VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Plankalkulation',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_KALK_PLAN_SPR_ZU PRIMARY KEY (mandant_id, plan_kalk_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen zur Planwertkalkulation aus clpkt';

