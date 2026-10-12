--==============================================================
-- Table: filialebene_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: filialebene_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FILIALEBENE_SPR_ZU_1 (
   filialebene_id                      INTEGER     NOT NULL COMMENT 'ID der Bandbreiten',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   filialebene_bez                     VARCHAR(80)      NOT NULL COLLATE 'en-ci' COMMENT 'Bandbreiten  (defensiv, offensiv und neutral)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FILIALEBENE_SPR_ZU PRIMARY KEY (filialebene_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS: Sprachabhängige Bezeichnung der Bandbreiten von Defensive Umsatzplanung (Bandbreite IST Umsatz zu Plan HL_1 auf Filialebene)';

