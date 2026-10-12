CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_wh_day_wgi_qty_prclc_2 AS SELECT client_id,
 client_desc,
 country_group_id,
 country_group_desc,
 gl_region_id,
 gl_region_desc,
 wh_id,
 wh_desc,
 aspect_id,
 aspect_desc,
 itemgroup_int_id,
 itemgroup_int_desc,
 dat_formdate,
 cnt_miss_item,
 cnt_miss_item_py,
  CASE
  WHEN cnt_miss_item IS NOT NULL
  THEN cnt_dat_miss_item
  ELSE NULL
  END AS cnt_dat_miss_item,
  CASE
  WHEN cnt_miss_item_py IS NOT NULL
  THEN cnt_dat_miss_item_py
  ELSE NULL
  END AS cnt_dat_miss_item_py,
 val_roc_prclc_wh,
 val_roc_prclc_wh_py,
 avg_stc_wh,
 avg_stc_wh_py
FROM ldl_p_lew_mart_msi.t_agg_wh_day_wgi_prclc_2
WHERE curr_tot_id = 0;