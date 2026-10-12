--==============================================================
-- Table: eps_druck_anlass_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_druck_anlass_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EPS_DRUCK_ANLASS_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   druck_anlass_id                     VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Anlass des Drucks; (z.B. PE (Preiserhöhung).',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   druck_anlass_bez                    VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Druckanlasses',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EPS_DRUCK_ANLASS_SPR_ZU PRIMARY KEY (mandant_id, druck_anlass_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Sprachabhängige Bezeichnungen der Druckanlässe aus EPS (z.B. PE = Preiserhöhung) - manuelle Beladung';

