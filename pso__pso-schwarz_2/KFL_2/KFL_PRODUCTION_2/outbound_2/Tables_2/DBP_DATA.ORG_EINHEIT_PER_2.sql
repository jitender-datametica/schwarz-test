CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.org_einheit_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
hr_objekt_id INTEGER NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);