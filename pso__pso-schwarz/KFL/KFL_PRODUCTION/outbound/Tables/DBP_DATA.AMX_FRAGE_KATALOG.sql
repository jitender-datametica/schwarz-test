--==============================================================
-- Table: amx_frage_katalog
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_frage_katalog
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_frage_katalog (
amx_frage_katalog_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID einer Frage aus dem Fragenkatalog, aus der Quelle abstract_guideline.id.'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex.'),
hauptbereich_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Hauptbereichs aus dem Quellfeld topic_id'),
teilbereich_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Teilbereichs aus dem Quellfeld content_area_id'),
frage_nr STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Nummer der Frage, aus dem Quellfeld sort_order.'),
amx_frage_bez STRING(500) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Fragestellung/Handlung, aus dem Quellfeld description_text.'),
amx_handlung_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID des Handlungstyps, aus dem Quellfeld checklist_logic_id.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_frage_katalog_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='VIS audimex - Die Tabelle amx_frage_katalog enthält dieVorlage- Fragen  der Prüfprogramme. Aus der Quelle audimex.abstract_guideline');