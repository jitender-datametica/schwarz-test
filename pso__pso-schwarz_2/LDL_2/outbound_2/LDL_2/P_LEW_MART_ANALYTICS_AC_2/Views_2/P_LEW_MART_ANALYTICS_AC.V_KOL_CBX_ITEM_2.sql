CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_kol_cbx_item_2 (client_id, client_id_order, client_cd,
client_block_cd, item_ian, mdm_item_sid, mdm_item_name, cy_week_advertise, client_order_total_qty, item_sid, item_name,
src_orig_item_nr, config_item_cd, src_matnr, range_plan_cd, cy_week_range_advertise_from, cy_week_range_advertise_to,
range_advertise_from_dt, range_advertise_to_dt, pre_item_ian, pre_mdm_item_sid, pre_mdm_item_name, pre_range_plan_cd,
pre_cy_week_range_advertise_from, pre_cy_week_range_advertise_to, pre_range_advertise_from_dt, pre_range_advertise_to_dt
, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_analytics.v_kol_cbx_item_2 AS CBX_ITM;