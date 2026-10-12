CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_l_branche_2 (
mandant_id INTEGER NOT NULL,
branche_id INTEGER DEFAULT 0 NOT NULL,
branche_bez STRING(40) DEFAULT ' ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);