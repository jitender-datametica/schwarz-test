CREATE OR REPLACE TABLE kfl_production_dbp_data.mandant_spr_zu_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1'),
spr_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='VIS - Zuordnung Sprachen der Mandanten ');