CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.org_einheit_zu_per_1 (
hr_objekt_id_zu STRING(10) COLLATE 'und:ci' NOT NULL,
richtung_kz STRING(1) COLLATE 'und:ci' NOT NULL,
relat STRING(3) COLLATE 'und:ci' NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
hr_objekt_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);