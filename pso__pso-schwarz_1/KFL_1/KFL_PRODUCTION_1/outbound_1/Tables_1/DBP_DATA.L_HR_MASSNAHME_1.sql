CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_hr_massnahme_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
hr_massnahme_grund_id STRING(2) COLLATE 'und:ci' NOT NULL,
hr_massnahme_id STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);