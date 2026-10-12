CREATE OR REPLACE TABLE kfl_production_dbp_data.ma_personalbereich_zu_per_2 (
system_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
buchungskreis_id INTEGER NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
kjmo INTEGER NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);