CREATE OR REPLACE TABLE smp_production_eval.ly_pen_2 (
retailer_name STRING(8),
store_id NUMERIC(29,5),
dat DATE,
store_adress STRING(527) COLLATE 'und:ci',
n_baskets_lc INTEGER,
n_baskets_all INTEGER,
fraction_baskets_lc STRING(16777216),
revenue_lc STRING(16777216),
revenue_all STRING(16777216),
fraction_revenue_lc STRING(16777216)
);