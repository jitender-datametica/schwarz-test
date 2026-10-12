CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_stock_webshop_daily_1 AS SELECT wshop_cd,
 prod_variant_sid,
 cal_dt,
 avail_to_promise_cnt,
 global_stock_cnt,
 avail_to_sell_cnt,
 receiv_on_dock_cnt,
 covered_remain_cnt,
 active_fg,
 alloc_stock_cnt,
 prod_variant_nr
FROM ldl_dig_lec_share.v_fact_stock_webshop_daily_1;