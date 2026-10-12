--==============================================================
-- Table: bezugsweg_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bezugsweg_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEZUGSWEG_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   bezugsweg_id                        INTEGER     NOT NULL COMMENT 'Kennzeichnet, ob der Artikel_2 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache im DWH',
   bezugsweg_bez                       VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Bezugswegs',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEZUGSWEG_SPR_ZU PRIMARY KEY (mandant_id, bezugsweg_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Sprachabhängige Bezeichnung des Bezugswegs';

