--==============================================================
-- Table: altersteilzeit_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: altersteilzeit_spr_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ALTERSTEILZEIT_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'PK - Mandant_1 im DWH',
   atz_phase_id                        VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Phase im Blockmodell. Gibt an, in welcher Phase sich der MA befindet, z.Bsp. BF',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   atz_bez                             VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Altersteilzeit-Phase',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ALTERSTEILZEIT_SPR_ZU PRIMARY KEY (mandant_id, atz_phase_id, spr_id) NOT ENFORCED
)  COMMENT = 'SHR - Sprachabhängige Bezeichnung der Altersteilzeit-Phasen';

