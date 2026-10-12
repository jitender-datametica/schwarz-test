CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.it_projekt_plan_2 (
it_projekt_id STRING(10) COLLATE 'und:ci' NOT NULL,
plan_revision_id BIGNUMERIC(38,0) NOT NULL,
planart_id BIGNUMERIC(38,0) NOT NULL,
sonstiger_aufwand NUMERIC(18,4) NOT NULL,
aktivierungsquote_intern_ist NUMERIC(18,4) NOT NULL,
aktivierungsquote_intern_plan NUMERIC(18,4) NOT NULL,
aktivierungsquote_extern_ist NUMERIC(18,4) NOT NULL,
aktivierungsquote_extern_plan NUMERIC(18,4) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
kapital_kostensatz NUMERIC(9,2) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);