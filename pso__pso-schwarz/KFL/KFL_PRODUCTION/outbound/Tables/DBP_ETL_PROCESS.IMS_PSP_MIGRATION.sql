CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ims_psp_migration (
psp_id_char_alt STRING(30) COLLATE 'und:ci',
mandant_id BIGNUMERIC(38,0),
psp_id_char_neu STRING(30) COLLATE 'und:ci',
dat_von DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);