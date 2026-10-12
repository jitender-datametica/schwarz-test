CREATE OR REPLACE TABLE smp_production_fe_mstr_temp.t_test_period_dooh_mk_1 (
dooh_campaign_name STRING(250) NOT NULL,
date_start DATE,
date_end DATE,
country_division_id STRING(16777216) NOT NULL,
duration INTEGER,
gtin_list STRING(16777216),
store_list STRING(16777216),
budget_spent NUMERIC(29,3),
date_updated DATETIME
);