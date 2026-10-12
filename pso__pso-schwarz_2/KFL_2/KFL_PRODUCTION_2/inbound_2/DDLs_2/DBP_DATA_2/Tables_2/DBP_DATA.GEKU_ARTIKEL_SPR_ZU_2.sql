--==============================================================
-- Table: geku_artikel_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_artikel_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_ARTIKEL_SPR_ZU_2 (
   geku_artikel_uid                    NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID eines GEKU-Artikels aus workflow_uid. Der GEKU-Artikel_2 besitzt keine Referenz zum Kaufland-Artikel_2',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   geku_artikel_bez                    VARCHAR(250)     COLLATE 'en-ci' COMMENT 'Bezeichnung des GeKu-Artikels aus code_name, z.Bsp. Einkaufswagen',
   quelle_spr_id                       NUMBER(38,0)     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_ARTIKEL_SPR_ZU PRIMARY KEY (geku_artikel_uid, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnung der GeKu-Artikel_2 aus s1_dwh_workflow_out';

