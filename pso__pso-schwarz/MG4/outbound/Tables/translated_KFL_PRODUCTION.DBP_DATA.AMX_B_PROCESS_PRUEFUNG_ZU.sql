CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_b_process_pruefung_zu (
business_process_id INTEGER NOT NULL
OPTIONS(description='ID des Geschäftsprozesses.Verweis auf ein Prüffeld mit dem Typ Prozess. Referenz auf pruef_feld_id. Aus dem Quellfeld audit_universe.business_process_id bzw.audit_universe.id'),
pruefung_id INTEGER NOT NULL OPTIONS(description='Die eindeutige ID einer Prüfung aus dem Quellfeld auditing.id'),
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (business_process_id, pruefung_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='VIS audimex - bildet n:m-Beziehung zwischen business_process und Pruefung ab. Wird im DWH befüllt');