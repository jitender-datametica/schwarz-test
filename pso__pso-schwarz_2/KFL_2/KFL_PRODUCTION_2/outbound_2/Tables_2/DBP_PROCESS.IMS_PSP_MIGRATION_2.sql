CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.ims_psp_migration_2 (
psp_id_char_alt STRING(30) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
psp_id_char_neu STRING(30) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);