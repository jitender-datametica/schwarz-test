--==============================================================
-- Table: eps_layout_groesse_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_layout_groesse_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EPS_LAYOUT_GROESSE_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   layout_groesse_id                   NUMBER(38,0)     NOT NULL COMMENT 'ID der Layoutgröße; (z.B. 1 = Mini, 9 = A4, …)',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   layout_groesse_bez                  VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Layoutgröße; (z.B. 1 = Mini, 9 = A4, …)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EPS_LAYOUT_GROESSE_SPR_ZU PRIMARY KEY (mandant_id, layout_groesse_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Sprachabhängige Bezeichnungen der Layoutgröße aus EPS (z.B. 1 = Mini, 9 = A4, …)';

