--==============================================================
-- Table: amx_frage_katalog_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_frage_katalog_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_FRAGE_KATALOG_1 (
   amx_frage_katalog_id                NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID einer Frage aus dem Fragenkatalog, aus der Quelle abstract_guideline.id.',
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex.',
   hauptbereich_id                     NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines Hauptbereichs aus dem Quellfeld topic_id',
   teilbereich_id                      NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines Teilbereichs aus dem Quellfeld content_area_id',
   frage_nr                            VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Nummer der Frage, aus dem Quellfeld sort_order.',
   amx_frage_bez                       VARCHAR(500)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Fragestellung/Handlung, aus dem Quellfeld description_text.',
   amx_handlung_typ_id                 NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID des Handlungstyps, aus dem Quellfeld checklist_logic_id.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_FRAGE_KATALOG PRIMARY KEY (amx_frage_katalog_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Die Tabelle amx_frage_katalog_1 enthält dieVorlage- Fragen  der Prüfprogramme. Aus der Quelle audimex.abstract_guideline';

