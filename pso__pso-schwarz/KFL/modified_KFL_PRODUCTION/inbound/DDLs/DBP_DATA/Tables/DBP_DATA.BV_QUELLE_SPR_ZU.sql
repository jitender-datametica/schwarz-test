--==============================================================
-- Table: bv_quelle_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bv_quelle_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:16 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BV_QUELLE_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant     ',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprachschlüssel',
   bv_quelle_id                        INTEGER     NOT NULL COMMENT 'BV Quelle',
   bv_quelle_bez                       VARCHAR(60)      COMMENT 'BV Quelle Bez.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BV_QUELLE_SPR_ZU PRIMARY KEY (mandant_id, spr_id, bv_quelle_id) NOT ENFORCED
)  COMMENT = 'Bestellvorschlag Quelle Texte (DD07V Domname ZSCM_DC_OP_SOURCE)';

