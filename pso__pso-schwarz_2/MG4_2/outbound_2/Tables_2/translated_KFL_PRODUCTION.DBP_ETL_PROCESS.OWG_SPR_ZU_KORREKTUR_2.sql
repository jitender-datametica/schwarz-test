CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.owg_spr_zu_korrektur_2 (
mandant_id INTEGER,
owg_id INTEGER,
spr_id INTEGER,
owg_bez STRING(400) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);