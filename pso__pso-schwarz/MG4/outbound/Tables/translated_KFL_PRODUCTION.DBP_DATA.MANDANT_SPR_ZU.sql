CREATE OR REPLACE TABLE kfl_production_dbp_data.mandant_spr_zu (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant'),
spr_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='VIS - Zuordnung Sprachen der Mandanten ');