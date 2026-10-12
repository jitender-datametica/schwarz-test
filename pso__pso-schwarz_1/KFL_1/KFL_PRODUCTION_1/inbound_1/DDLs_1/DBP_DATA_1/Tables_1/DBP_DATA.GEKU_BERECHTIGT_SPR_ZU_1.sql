--==============================================================
-- Table: geku_berechtigt_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_berechtigt_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_BERECHTIGT_SPR_ZU_1 (
   berechtigt_fg                       NUMBER(38,0)     NOT NULL COMMENT 'Berechtigt=1 / Unberechtigt=0, aus answer_qualified',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   berechtigt_bez                      VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung für berechtigt / unberechtigt',
   quelle_spr_id                       NUMBER(38,0)     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_BERECHTIGT_SPR_ZU PRIMARY KEY (berechtigt_fg, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnung für das Berechtigt Flag';

