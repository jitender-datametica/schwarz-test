--==============================================================
-- Table: berichts_pos_inv_grp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: berichts_pos_inv_grp_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BERICHTS_POS_INV_GRP_SPR_ZU (
   berichts_pos_invest_grp_id          INTEGER     NOT NULL COMMENT 'Die Berichtsposition- Gruppierung  wird direkt im DWH gepflegt ',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   berichts_pos_invest_grp_bez         VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Gruppierung für Berichtspositionen. Initial versorgt/manuelle Pflege',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BERICHTS_POS_INV_GRP_SPR_ZU PRIMARY KEY (berichts_pos_invest_grp_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMS - Sprachabhängige Bezeichnungen der Berichtspositionen- Gruppierungen für Investitionen. Wird im DWH gepflegt';

