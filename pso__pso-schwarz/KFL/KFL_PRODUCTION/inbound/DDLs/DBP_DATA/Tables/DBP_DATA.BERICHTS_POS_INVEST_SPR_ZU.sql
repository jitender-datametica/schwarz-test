--==============================================================
-- Table: berichts_pos_invest_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: berichts_pos_invest_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BERICHTS_POS_INVEST_SPR_ZU (
   berichts_position_invest_id         NUMBER(38,0)     NOT NULL COMMENT 'Die Berichtsposition für Investitionen wird direkt im DWH gepflegt ',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   berichts_position_invest_bez        VARCHAR(80)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Berichtsposition',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BERICHTS_POS_INVEST_SPR_ZU PRIMARY KEY (berichts_position_invest_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMS - Sprachabhängige Bezeichnungen der Berichtspositionen für Investitionen  Wird im DWH gepflegt';

