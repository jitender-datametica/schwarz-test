--==============================================================
-- Table: eps_papierart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_papierart_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EPS_PAPIERART_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   papierart_id                        INTEGER     NOT NULL COMMENT 'ID der Papierart; (z.B. 3 = weiss A4, 200 = neon-orange A4, …)',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   papierart_bez                       VARCHAR(60)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Papierart; (z.B. 3 = weiss A4, 200 = neon-orange A4, …)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EPS_PAPIERART_SPR_ZU PRIMARY KEY (mandant_id, papierart_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Sprachabhängige Bezeichnungen der Papierarten aus EPS (z.B. 3 = weiss A4, 200 = neon-orange A4, …) ';

