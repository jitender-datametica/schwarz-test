CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_frage_kat_pruef_progr_zu (
frage_kat_pruef_progr_zu_id INTEGER NOT NULL
OPTIONS(description='Eindeutige ID der Beziehungstabelle aus dem Quellfeld ID'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
pruef_programm_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID des Prüfprogramms aus dem Quellfeld audit_concept_id'),
amx_frage_katalog_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID einer Frage aus dem Fragenkatalog aus der Quelle abstract_guideline.id'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (frage_kat_pruef_progr_zu_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='VIS audimex - Zuordnungs-Tabelle des Fragen-Katalogs zum Prüf-Programm aus der Quelltabelle audit_concept_to_abs_guideline');