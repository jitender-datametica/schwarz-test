--==============================================================
-- Table: abschriftart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_spr_zu
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABSCHRIFTART_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   abschriftart_id                     INTEGER     NOT NULL COMMENT 'Abschriftenart  -  numerisch',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache ID',
   abschriftart_bez                    VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Abschriftenart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABSCHRIFTART_SPR_ZU PRIMARY KEY (mandant_id, abschriftart_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Sprachabhängige Bezeichnungen der Abschriftenschlüssel';

