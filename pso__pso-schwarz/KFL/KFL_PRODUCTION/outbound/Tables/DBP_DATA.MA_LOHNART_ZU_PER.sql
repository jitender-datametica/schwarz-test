CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_lohnart_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
lohnart_id STRING(5) COLLATE 'und:ci' NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
stunden_lohnart NUMERIC(9,2) NOT NULL,
system_id BIGNUMERIC(38,0),
kostenstelle_id STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);