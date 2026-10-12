CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.x_20190326_v_stock_location_item_5945453 (client_id, loc_sid, item_sid,
dwh_cal_dt, stock_calc_qty, stock_inv_qty, stock_real_qty, stock_inv_diff_calc, price, price_net, src_space_switch,
store_storage_qty, dwh_valid_from, dwh_valid_to) AS SELECT *
FROM ldl_p_lew_bil.v_stock_location_item;