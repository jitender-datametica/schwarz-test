CREATE OR REPLACE TABLE idq_production_ldl_apt_results.t_dq_rep_apt_calculation_time (
ref_calculation_time DATETIME,
ref_day_id INTEGER,
ref_country_id INTEGER,
week_12_before STRING(10),
week_11_before STRING(10),
week_10_before STRING(10),
week_9_before STRING(10),
week_8_before STRING(10),
week_current STRING(10),
week_8_after STRING(10),
week_9_after STRING(10),
week_10_after STRING(10),
week_11_after STRING(10),
week_12_after STRING(10)
);