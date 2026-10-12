CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ekc_plan_upload (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
hwg_id BIGNUMERIC(38,0) NOT NULL,
pv BIGNUMERIC(38,5),
sa BIGNUMERIC(38,5),
af BIGNUMERIC(38,5),
ab BIGNUMERIC(38,5),
wa BIGNUMERIC(38,5),
anteil_umsatz_hwg BIGNUMERIC(38,5),
wa_af BIGNUMERIC(38,5),
wa_sa BIGNUMERIC(38,5),
td_insert TIMESTAMP,
td_update TIMESTAMP
);