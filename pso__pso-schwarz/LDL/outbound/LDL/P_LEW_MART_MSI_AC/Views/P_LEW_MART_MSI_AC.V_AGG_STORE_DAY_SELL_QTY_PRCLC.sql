CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_agg_store_day_sell_qty_prclc (client_id, client_desc, account_manager_id
, account_manager_name, sales_manager_id, sales_manager_name, move_to_store_id, move_store_desc, wh_id, wh_desc,
wh_id_exp, aspect_id, aspect_desc, dat_formdate, wt_hrs_net, wt_hrs_net_py, mt_hrs_net, mt_hrs_net_py) AS SELECT *
FROM ldl_p_lew_mart_msi.v_agg_store_day_sell_qty_prclc;