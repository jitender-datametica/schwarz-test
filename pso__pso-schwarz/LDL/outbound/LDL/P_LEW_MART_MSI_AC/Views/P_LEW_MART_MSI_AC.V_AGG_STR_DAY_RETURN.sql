CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_agg_str_day_return (client_id, store_id, loc_sid, wh_id, item_id,
subitemgroup_id, booking_dat, order_return_reason_cd, return_qty, return_val, return_net_val, currency_iso_cd) AS SELECT
 *
FROM ldl_p_lew_mart_msi.v_agg_str_day_return;