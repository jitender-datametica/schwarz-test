CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_qv_agg_wh_day_miss_itm_2 (client_id, country_group_id, gl_region_id, wh_id
, aspect_id, currency_iso_cd, curr_tot_id, dat_formdate, miss_item_cnt_cy, miss_item_cnt_fa_cy, miss_item_cnt_py,
miss_item_cnt_fa_py, store_day_cnt_cy, store_day_cnt_fa_cy, store_day_cnt_py, store_day_cnt_fa_py, miss_item_fg_cy,
miss_item_fg_fa_cy, miss_item_fg_py, miss_item_fg_fa_py) AS SELECT *
FROM ldl_p_lew_mart_lead.v_qv_agg_wh_day_miss_itm_2;