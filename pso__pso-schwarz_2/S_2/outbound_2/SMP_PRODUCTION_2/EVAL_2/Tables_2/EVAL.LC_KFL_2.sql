CREATE OR REPLACE TABLE smp_production_eval.lc_kfl_2 (
retailer_name STRING(3),
store_id INTEGER,
dat DATE,
n_baskets_lc INTEGER,
n_baskets_all INTEGER,
fraction_baskets_lc NUMERIC(29,6),
revenue_lc NUMERIC(29,4),
revenue_all NUMERIC(29,4),
fraction_revenue_lc BIGNUMERIC(38,10),
mandant_id INTEGER,
wup_id INTEGER,
wup_name_v STRING(160) COLLATE 'und:ci',
wup_name_e STRING(160) COLLATE 'und:ci',
wup_standort STRING(160) COLLATE 'und:ci',
wup_plz STRING(40) COLLATE 'und:ci',
wup_str STRING(160) COLLATE 'und:ci'
);