CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_de_b_process_pruefung_zu_1 (
business_process_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Geschäftsprozesses'),
pruefung_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID der Prüfung'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (business_process_id, pruefung_id) NOT ENFORCED
)
OPTIONS(description='KMR - Audimex. Bildet n:m Beziehungen für business_process_id und Pruefungen ab für Kurzcheck DE Daten');