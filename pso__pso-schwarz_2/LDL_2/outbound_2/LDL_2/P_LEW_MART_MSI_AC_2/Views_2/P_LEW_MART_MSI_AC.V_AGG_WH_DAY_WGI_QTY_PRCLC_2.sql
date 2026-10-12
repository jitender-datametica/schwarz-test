CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_agg_wh_day_wgi_qty_prclc_2 (client_id, client_desc, country_group_id,
country_group_desc, gl_region_id, gl_region_desc, wh_id, wh_desc, aspect_id, aspect_desc, itemgroup_int_id,
itemgroup_int_desc, dat_formdate, cnt_miss_item, cnt_miss_item_py, cnt_dat_miss_item, cnt_dat_miss_item_py,
val_roc_prclc_wh, val_roc_prclc_wh_py, avg_stc_wh, avg_stc_wh_py) AS SELECT *
FROM ldl_p_lew_mart_msi.v_agg_wh_day_wgi_qty_prclc_2;