--==============================================================
-- Table: bezugsweg_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bezugsweg_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEZUGSWEG_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   bezugsweg_id                        NUMBER(38,0)     NOT NULL COMMENT 'Kennzeichnet, ob der Artikel_1 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprache im DWH',
   bezugsweg_bez                       VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Bezugswegs',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEZUGSWEG_SPR_ZU PRIMARY KEY (mandant_id, bezugsweg_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Sprachabhängige Bezeichnung des Bezugswegs';

