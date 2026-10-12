--==============================================================
-- Table: geku_grund_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_grund_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_GRUND_SPR_ZU_2 (
   geku_grund_uid                      NUMBER(18,0)     NOT NULL COMMENT 'Eindeutiger Schlüssel der Geku-Gründe aus workflow_level2_uid',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   geku_grund_bez                      VARCHAR(250)     COLLATE 'en-ci' COMMENT 'Bezeichnung des GeKu-Grundes aus code_name',
   quelle_spr_id                       NUMBER(38,0)     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_GRUND_SPR_ZU PRIMARY KEY (geku_grund_uid, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Bezeichnung der GeKu-Gründe aus s1_dhw_workflow_level2_out';

