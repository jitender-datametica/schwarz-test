CREATE OR REPLACE TABLE kfl_production_dbp_data.flw_l_fehlerklasse (
mandant_id INTEGER NOT NULL,
fehlerklasse_id INTEGER NOT NULL,
system_id INTEGER NOT NULL,
fehlerklasse_kennzahl INTEGER NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);