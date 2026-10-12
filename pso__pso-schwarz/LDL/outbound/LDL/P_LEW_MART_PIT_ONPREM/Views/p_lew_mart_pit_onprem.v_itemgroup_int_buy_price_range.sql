CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_itemgroup_int_buy_price_range AS SELECT client_id,
 src_itemgrp_int_cd,
 src_subitemgrp_cd,
 buy_price_range_days,
 dwh_valid_from,
 dwh_valid_to
FROM ldl_p_lew_mart_pit_onprem.t_itemgroup_int_buy_price_range;