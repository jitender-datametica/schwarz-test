CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_wh_day_sell_qty_prclc_2 AS SELECT client_id,
 client_desc,
 country_group_id,
 country_group_desc,
 gl_region_id,
 gl_region_desc,
 wh_id,
 wh_desc,
 aspect_id,
 aspect_desc,
 dat_formdate,
 wt_hrs_net,
 wt_hrs_net_py,
 mt_hrs_net,
 mt_hrs_net_py
FROM ldl_p_lew_mart_msi.t_agg_wh_day_sell_prclc_2
WHERE curr_tot_id = 0;