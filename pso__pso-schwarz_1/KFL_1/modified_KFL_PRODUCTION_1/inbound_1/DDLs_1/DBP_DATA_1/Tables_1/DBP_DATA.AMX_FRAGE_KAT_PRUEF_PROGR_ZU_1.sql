--==============================================================
-- Table: amx_frage_kat_pruef_progr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_frage_kat_pruef_progr_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_FRAGE_KAT_PRUEF_PROGR_ZU_1 (
   frage_kat_pruef_progr_zu_id         INTEGER     NOT NULL COMMENT 'Eindeutige ID der Beziehungstabelle aus dem Quellfeld ID',
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   pruef_programm_id                   INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID des Prüfprogramms aus dem Quellfeld audit_concept_id',
   amx_frage_katalog_id                INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID einer Frage aus dem Fragenkatalog aus der Quelle abstract_guideline.id',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_FRAGE_KAT_PRUEF_PROGR_ZU PRIMARY KEY (frage_kat_pruef_progr_zu_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Zuordnungs-Tabelle des Fragen-Katalogs zum Prüf-Programm aus der Quelltabelle audit_concept_to_abs_guideline';

