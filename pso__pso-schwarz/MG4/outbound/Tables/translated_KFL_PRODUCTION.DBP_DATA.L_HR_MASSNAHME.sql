CREATE OR REPLACE TABLE kfl_production_dbp_data.l_hr_massnahme (
mandant_id INTEGER NOT NULL,
hr_massnahme_grund_id STRING(2) COLLATE 'und:ci' NOT NULL,
hr_massnahme_id STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);