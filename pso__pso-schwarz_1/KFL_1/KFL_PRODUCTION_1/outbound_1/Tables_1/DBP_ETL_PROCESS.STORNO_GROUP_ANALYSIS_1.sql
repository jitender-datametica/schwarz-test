CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.storno_group_analysis_1 (
bon_id STRING(100),
scenario_group_id BIGNUMERIC(38,0),
scenario_group_id_description STRING(255),
scenario_id BIGNUMERIC(38,0),
scenario_id_description STRING(255),
threshold_regional NUMERIC(18,4),
threshold_national NUMERIC(18,4)
);