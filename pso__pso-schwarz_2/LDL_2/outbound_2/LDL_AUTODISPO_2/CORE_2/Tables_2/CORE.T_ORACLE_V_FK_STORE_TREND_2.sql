CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_store_trend_2 (
country_2 STRING(16777216),
fst_storetrend_id BIGNUMERIC(38,0),
fst_trendtype STRING(16777216),
fst_wh BIGNUMERIC(38,0),
fst_store BIGNUMERIC(38,0),
fst_orderarea BIGNUMERIC(38,0),
fst_articlegroup BIGNUMERIC(38,0),
fst_group_nr BIGNUMERIC(38,0),
fst_subgroup_nr BIGNUMERIC(38,0),
fst_article STRING(16777216),
fst_percent BIGNUMERIC(38,0),
fst_datefrom BIGNUMERIC(38,0),
fst_dateto BIGNUMERIC(38,0),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP,
snflk_insert_tmsp TIMESTAMP,
snflk_update_tmsp TIMESTAMP
) CLUSTER BY country_2, fst_wh, fst_datefrom, fst_dateto;