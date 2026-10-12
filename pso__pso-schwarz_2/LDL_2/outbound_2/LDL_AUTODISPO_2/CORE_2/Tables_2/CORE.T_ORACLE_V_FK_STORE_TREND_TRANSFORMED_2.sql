CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_store_trend_transformed_2 (
country_2 STRING(16777216),
date DATE,
store_nr BIGNUMERIC(38,0),
store_wh BIGNUMERIC(38,0),
itemno STRING(16777216),
fst_percent BIGNUMERIC(38,0),
fst_storetrend_id BIGNUMERIC(38,0),
fst_trendtype STRING(16777216),
scenario STRING(16777216),
snflk_insert_tmsp TIMESTAMP
) CLUSTER BY country_2, date, store_wh, itemno;