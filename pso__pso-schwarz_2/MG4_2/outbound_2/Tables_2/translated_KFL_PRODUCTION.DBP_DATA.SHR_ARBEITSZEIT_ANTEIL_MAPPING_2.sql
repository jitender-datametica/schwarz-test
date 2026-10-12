CREATE OR REPLACE TABLE kfl_production_dbp_data.shr_arbeitszeit_anteil_mapping_2 (
mandant_id INTEGER NOT NULL,
kjmo_bis INTEGER NOT NULL,
anz_stunden_bis NUMERIC(9,2) NOT NULL,
kjmo_von INTEGER DEFAULT 0,
anz_stunden_von NUMERIC(9,2) DEFAULT 0 NOT NULL,
arbeitszeit_anteil NUMERIC(9,2) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);