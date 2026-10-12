CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pep_abteilung_1 (
idabteilungen BIGNUMERIC(38,0) NOT NULL,
pep_abt_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
abt_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);