CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.pep_abteilung_2 (
idabteilungen BIGNUMERIC(38,0) NOT NULL,
pep_abt_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
abt_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);