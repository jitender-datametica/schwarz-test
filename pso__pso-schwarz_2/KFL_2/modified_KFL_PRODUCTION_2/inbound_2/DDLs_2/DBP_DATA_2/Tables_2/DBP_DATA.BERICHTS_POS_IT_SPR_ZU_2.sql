--==============================================================
-- Table: berichts_pos_it_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: berichts_pos_it_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BERICHTS_POS_IT_SPR_ZU_2 (
   berichts_position_it_id             INTEGER     NOT NULL COMMENT 'Die Berichtsposition für Kostenarten Quelle Z_KL_TRANSACTION_CLASS - Lookup_id wird im DWH durch eine_2 fortlaufende Nummer ersetzt',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   berichts_position_it_bez            VARCHAR(80)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Berichtsposition',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BERICHTS_POS_IT_SPR_ZU PRIMARY KEY (berichts_position_it_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMS - Sprachabhängige Bezeichnungen der Berichtspositionen für IT-Projekte - Quelle Z_KL_TRANSACTION_CLASS - Lookup_id wird im DWH durch eine_2 fortlaufende Nummer ersetzt';

