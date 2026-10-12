CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mandant_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='VIS - Zuordnung Sprachen der Mandanten ');