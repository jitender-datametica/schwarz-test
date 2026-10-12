CREATE OR REPLACE TABLE kfl_production_dbp_data.mandant_spr_zu_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2'),
spr_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='VIS - Zuordnung Sprachen der Mandanten ');