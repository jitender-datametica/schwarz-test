CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.bon_metric_threshold_regional_vals (
bon_id STRING(100),
bon_dat DATE,
wup_id BIGNUMERIC(38,0),
mandant_id BIGNUMERIC(38,0),
scenario_id BIGNUMERIC(38,0),
threshold_regional NUMERIC(18,4)
);