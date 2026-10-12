CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.inventur_termin (
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat_plan_zaehlung DATE NOT NULL,
inventurart_id BIGNUMERIC(38,0),
inventurart_kurz_bez STRING(20) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
inventurart_bez STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
dat_von DATE,
dat_bis DATE,
inventurart_int_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);