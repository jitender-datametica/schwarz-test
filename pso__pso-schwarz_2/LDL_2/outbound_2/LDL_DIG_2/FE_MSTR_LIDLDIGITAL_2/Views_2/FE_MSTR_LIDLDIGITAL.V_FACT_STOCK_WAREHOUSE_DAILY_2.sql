/*
Change History
08.05.2023    ABA    Replaced core.v_agg_stock_warehouse_daily by core.t_fact_stock_warehouse_daily_2 and added following fields to the view: BLOCKED_STOCK_CNT, BLOCKED_STOCK_RETURN_CNT, UNRESTRICTED_STOCK_CNT, RESTRICTED_STOCK_CNT, IN_TRANSFER_CNT, IN_QTY_INSPECTION_CNT, TOTAL_STOCK_CNT
14.01.2025	  EMO	 Deleted COVERED_REMAIN_CNT field
*/


CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_stock_warehouse_daily_2 (wh_sid, prod_variant_sid, cal_dt,
stock_valid_fg, avail_to_promise_cnt, avail_to_sell_cnt, receiv_on_dock_cnt, in_transit_cnt, blocked_stock_cnt,
blocked_stock_return_cnt, unrestricted_stock_cnt, restricted_stock_cnt, in_transfer_cnt, in_qty_inspection_cnt,
total_stock_cnt) AS SELECT wh_sid,
 prod_variant_sid,
 cal_dt,
 active_fg AS stock_valid_fg,
 IFNULL(avail_to_promise_cnt, 0) AS avail_to_promise_cnt,
 IFNULL(avail_to_sell_cnt, 0) AS avail_to_sell_cnt,
 IFNULL(receiv_on_dock_cnt, 0) AS receiv_on_dock_cnt,
 IFNULL(in_transit_cnt, 0) AS in_transit_cnt,
 IFNULL(blocked_stock_cnt, 0) AS blocked_stock_cnt,
 IFNULL(blocked_stock_return_cnt, 0) AS blocked_stock_return_cnt,
 IFNULL(unrestricted_stock_cnt, 0) AS unrestricted_stock_cnt,
 IFNULL(restricted_stock_cnt, 0) AS restricted_stock_cnt,
 IFNULL(in_transfer_cnt, 0) AS in_transfer_cnt,
 IFNULL(in_qty_inspection_cnt, 0) AS in_qty_inspection_cnt,
 IFNULL(total_stock_cnt, 0) AS total_stock_cnt
FROM ldl_dig_lec_share.v_fact_stock_warehouse_daily_2;