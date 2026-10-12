CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ssm_weekly_plan (
kjwo BIGNUMERIC(38,0),
mandant_id BIGNUMERIC(38,0),
land STRING(2) COLLATE 'und:ci',
markt BIGNUMERIC(38,0),
dat DATE,
wtag_id BIGNUMERIC(38,0),
umsatz_hl NUMERIC(18,2),
wrg_id STRING(3) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);