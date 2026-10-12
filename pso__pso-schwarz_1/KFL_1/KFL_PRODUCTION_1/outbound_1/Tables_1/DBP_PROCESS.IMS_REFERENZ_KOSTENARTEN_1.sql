CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.ims_referenz_kostenarten_1 (
kostenart_id STRING(10) COLLATE 'und:ci' NOT NULL,
ahk_aufwand_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);