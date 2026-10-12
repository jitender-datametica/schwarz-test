CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_itemgroup_int_buy_price_range_1 (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
src_itemgrp_int_cd STRING(16777216) NOT NULL,
src_subitemgrp_cd STRING(16777216),
buy_price_range_days BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE DEFAULT DATE '1900-01-01' NOT NULL,
dwh_valid_to DATE DEFAULT DATE '9999-12-31' NOT NULL
);