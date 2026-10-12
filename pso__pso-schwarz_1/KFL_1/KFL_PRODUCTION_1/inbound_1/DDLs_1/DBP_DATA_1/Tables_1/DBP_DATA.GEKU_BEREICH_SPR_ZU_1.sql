--==============================================================
-- Table: geku_bereich_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_bereich_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_BEREICH_SPR_ZU_1 (
   geku_bereich_uid                    NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID des GeKu-Bereichs aus workflow_level1_uid',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   geku_bereich_bez                    VARCHAR(250)     COLLATE 'en-ci' COMMENT 'Bezeichnung des GeKu-Bereichs aus code_name',
   quelle_spr_id                       NUMBER(38,0)     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_BEREICH_SPR_ZU PRIMARY KEY (geku_bereich_uid, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Bezeichnung der GeKu-Gründe aus s1_dhw_workflow_level1_out';

