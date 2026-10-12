CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_l_business_process (
business_process_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='ID des Geschäftsprozesses.Verweis auf ein Prüffeld mit dem Typ Prozess. Referenz auf pruef_feld_id. Aus dem Quellfeld audit_universe.business_process_id bzw.audit_universe.id'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
business_process_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Die Bezeichnung (der Name) des Prüffeldes aus der Quellspalte audit_universe.name, z.Bsp. Arbeitsschutz'),
pruef_feld_typ_id INTEGER NOT NULL
OPTIONS(description='Eindeutige ID eines Prüffeld-Typs aus der Quelle audit_universe.au_type_id'),
in_matrix_pruefgebiete_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag aus dem Quellfeld shows_up_in_dimension'),
aktiv_fg INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Flag zeigt an, ob das Prüffeld aktiv ist. Aus dem Quellfeld active'),
amx_grp_id INTEGER
OPTIONS(description='Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen\n            '),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (business_process_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - audimex - Lookup Tabelle der Business-Prozesse (z.B. Prüfprogram für eine Filiale). Quelle ist audit_universe, wird im DWH befüllt');