CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.sort_ist3_reduction_1 (
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
sm_id BIGNUMERIC(38,0),
ksm_id STRING(4) COLLATE 'und:ci',
kassenumsatz_artikel FLOAT64,
anz_tage_artikel BIGNUMERIC(38,0),
anz_tage_listung_artikel BIGNUMERIC(38,0)
);