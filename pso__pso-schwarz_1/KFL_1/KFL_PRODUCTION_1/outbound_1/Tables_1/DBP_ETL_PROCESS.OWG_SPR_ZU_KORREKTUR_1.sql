CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.owg_spr_zu_korrektur_1 (
mandant_id BIGNUMERIC(38,0),
owg_id BIGNUMERIC(38,0),
spr_id BIGNUMERIC(38,0),
owg_bez STRING(400) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);