--==============================================================
-- Table: amx_frage_katalog_typ_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_frage_katalog_typ_zu
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_FRAGE_KATALOG_TYP_ZU (
   amx_system_id                       INTEGER     NOT NULL COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   amx_frage_katalog_id                INTEGER     NOT NULL COMMENT 'Eindeutige ID einer Frage aus dem Fragenkatalog aus der Quelle abstract_guideline.id',
   frage_typ_id                        INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines Fragentyps aus dem Quellfeld guideline_type.id',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_FRAGE_KATALOG_TYP_ZU PRIMARY KEY (amx_system_id, amx_frage_katalog_id, frage_typ_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Zuordnungs-Tabelle der Fragen-Typen zum Fragenkatalog';

