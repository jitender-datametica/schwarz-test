CREATE OR REPLACE TABLE idq_production_idq_results.gx_check_results_1 (
gx_source_system_id BIGNUMERIC(38,0),
calculation_timestamp DATETIME,
record_count BIGNUMERIC(38,0),
error_count BIGNUMERIC(38,0),
dq_score BIGNUMERIC(38,0),
partial_error_list STRING(2000),
is_error_detected BIGNUMERIC(38,0)
);