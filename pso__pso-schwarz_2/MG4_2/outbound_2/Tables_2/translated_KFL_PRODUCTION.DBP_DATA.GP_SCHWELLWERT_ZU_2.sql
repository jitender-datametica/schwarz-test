CREATE OR REPLACE TABLE kfl_production_dbp_data.gp_schwellwert_zu_2 (
mandant_id INTEGER NOT NULL,
gp_id INTEGER NOT NULL,
sw_id INTEGER NOT NULL,
kj INTEGER NOT NULL,
sw_oben NUMERIC(9,6) NOT NULL,
sw_unten NUMERIC(9,6) NOT NULL,
sw_fg INTEGER NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);