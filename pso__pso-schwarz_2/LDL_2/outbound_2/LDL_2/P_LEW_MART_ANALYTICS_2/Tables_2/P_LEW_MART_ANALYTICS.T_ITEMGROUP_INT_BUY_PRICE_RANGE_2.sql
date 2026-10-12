CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_itemgroup_int_buy_price_range_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
src_itemgrp_int_cd STRING(20) NOT NULL,
src_subitemgrp_cd STRING(20),
buy_price_range_days BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL
);