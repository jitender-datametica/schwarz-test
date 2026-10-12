--==============================================================
-- Table: abschriftart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_spr_zu_2
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABSCHRIFTART_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   abschriftart_id                     INTEGER     NOT NULL COMMENT 'Abschriftenart  -  numerisch',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache ID',
   abschriftart_bez                    VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Abschriftenart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABSCHRIFTART_SPR_ZU PRIMARY KEY (mandant_id, abschriftart_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Sprachabhängige Bezeichnungen der Abschriftenschlüssel';

