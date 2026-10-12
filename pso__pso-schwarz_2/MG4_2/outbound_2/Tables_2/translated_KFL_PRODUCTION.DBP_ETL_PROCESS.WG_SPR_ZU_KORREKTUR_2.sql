CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.wg_spr_zu_korrektur_2 (
mandant_id INTEGER,
wg_id INTEGER,
spr_id INTEGER,
wg_bez STRING(400) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);