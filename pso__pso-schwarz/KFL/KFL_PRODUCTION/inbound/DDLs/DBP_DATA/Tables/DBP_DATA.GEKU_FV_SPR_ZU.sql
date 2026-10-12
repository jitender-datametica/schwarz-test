--==============================================================
-- Table: geku_fv_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_fv_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_FV_SPR_ZU (
   fv_fg                               NUMBER(38,0)     NOT NULL COMMENT 'Flag für Eigen/Fremdverteilung. Wert = 1 ist FV',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   fv_bez                              VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung für Fremd-/Eigenverteilung',
   quelle_spr_id                       NUMBER(38,0)     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_FV_SPR_ZU PRIMARY KEY (fv_fg, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnung für Fremd-/Eigenverteilung - manuell befüllt';

