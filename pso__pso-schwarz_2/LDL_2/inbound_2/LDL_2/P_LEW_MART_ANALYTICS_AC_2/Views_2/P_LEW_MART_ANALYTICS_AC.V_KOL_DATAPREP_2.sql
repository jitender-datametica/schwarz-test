CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_KOL_DATAPREP_2
(
      client_id
    , item_ian
    , adv_dt
    , item_descr
    , sup_name
    , range_plan_cd
    , src_familygrp_cd
    , item_fam_grp_descr
    , uwg_cd
    , category_cd
    , cbx_item_doc_status
    , buyer_cd
    , ean_size_name
    , ean_style_name
    , country_cbx_cd
    , sort_agg_level_val
    , client_block_cd
    , pack_list_name
    , item_part_cnt
    , pack_assort_type
    , ad_theme_am
    , ad_theme_cd
    , ad_theme_name
    , src_style_uniqids_cd
    , agg_level
    , agg_level_value
    , agg_level_name
    , kol_content_qty
    , kol_content_calc_qty
    , proportion_kol_qty
    , delivery_cntry_ian_adv_qty
    , delivery_cntry_agg_level_adv_qty
    , sales_7d_qty
    , sales_1d_qty
    , sales_ian_1d_qty
    , sales_ratio_ian_qty
    , sales_ratio_agg_level_qty
    , cbx_primary_key_null_dq_fg
    , no_sales_dq_fg
    , no_sales_ian_dq_fg
    , no_deliveries_cntry_dq_fg
    , cbx_sort_ian_val_null_dq_fg
    , cbx_extra_columns_null_dq_fg
    , ean_equals_ian_dq_fg
    , kol_content_not_equals_calc_dq_fg
    , single_ean_bl_fg
    , too_large_ian_avq_dq_fg
    , too_large_agg_avq_dq_fg
    , different_sort_in_block_bl_fg
    , different_sort_in_int_bl_fg
    , different_kollo_in_block_bl_fg
    , different_kollo_in_int_bl_fg
    , different_eans_in_block_bl_fg
    , different_eans_in_int_bl_fg
    , no_wt_available_dq_fg
    , more_than_one_adv_bl_fg
    , opening_hours_missing_dq_fg
    , target_proportion_cntry_qty
    , target_proportion_block_qty
    , target_proportion_int_qty
    , target_sort_cntry_val
    , target_sort_block_val
    , target_sort_int_val
    , target_sort_cntry_round_val
    , target_sort_block_round_val
    , target_sort_int_round_val
    , target_proportion_1d_cntry_qty
    , target_proportion_1d_block_qty
    , target_proportion_1d_int_qty
    , target_sort_1d_cntry_val
    , target_sort_1d_cntry_round_val
    , target_sort_1d_block_val
    , target_sort_1d_block_round_val
    , target_sort_1d_int_val
    , target_sort_1d_int_round_val
    , grid_point_sales_ratio_1_qty
    , grid_point_sales_ratio_2_qty
    , grid_point_sales_ratio_3_qty
    , grid_point_sales_ratio_4_qty
    , grid_point_sales_ratio_5_qty
    , grid_point_sales_ratio_6_qty
    , grid_point_sales_ratio_7_qty
    , grid_point_sales_ratio_8_qty
    , grid_point_sales_ratio_9_qty
    , grid_point_sales_ratio_10_qty
    , grid_point_sales_ratio_end_qty
    , grid_point_hours_1_val
    , grid_point_hours_2_val
    , grid_point_hours_3_val
    , grid_point_hours_4_val
    , grid_point_hours_5_val
    , grid_point_hours_6_val
    , grid_point_hours_7_val
    , grid_point_hours_8_val
    , grid_point_hours_9_val
    , grid_point_hours_10_val
    , grid_point_hours_end_val
    , grid_point_hours_end_ian_val
    , cbx_sort_val_null_dq_fg
    , too_large_agg_ian_avq_dq_fg
)
AS
   SELECT
         client_id,
   item_ian,
   adv_dt,
   item_descr,
   sup_name,
   range_plan_cd,
   src_familygrp_cd,
   item_fam_grp_descr,
   uwg_cd,
   category_cd,
   cbx_item_doc_status,
   buyer_cd,
   ean_size_name,
   ean_style_name,
   country_cbx_cd,
   sort_agg_level_val,
   client_block_cd,
   pack_list_name,
   item_part_cnt,
   pack_assort_type,
   ad_theme_am,
   ad_theme_cd,
   ad_theme_name,
   src_style_uniqids_cd,
   agg_level,
   agg_level_value,
   agg_level_name,
   kol_content_qty,
   kol_content_calc_qty,
   proportion_kol_qty,
   delivery_cntry_ian_adv_qty,
   delivery_cntry_agg_level_adv_qty,
   sales_7d_qty,
   sales_1d_qty,
   sales_ian_1d_qty,
   sales_ratio_ian_qty,
   sales_ratio_agg_level_qty,
   cbx_primary_key_null_dq_fg,
   no_sales_dq_fg,
   no_sales_ian_dq_fg,
   no_deliveries_cntry_dq_fg,
   cbx_sort_ian_val_null_dq_fg,
   cbx_extra_columns_null_dq_fg,
   ean_equals_ian_dq_fg,
   kol_content_not_equals_calc_dq_fg,
   single_ean_bl_fg,
   too_large_ian_avq_dq_fg,
   too_large_agg_avq_dq_fg,
   different_sort_in_block_bl_fg,
   different_sort_in_int_bl_fg,
   different_kollo_in_block_bl_fg,
   different_kollo_in_int_bl_fg,
   different_eans_in_block_bl_fg,
   different_eans_in_int_bl_fg,
   no_wt_available_dq_fg,
   more_than_one_adv_bl_fg,
   opening_hours_missing_dq_fg,
   target_proportion_cntry_qty,
   target_proportion_block_qty,
   target_proportion_int_qty,
   target_sort_cntry_val,
   target_sort_block_val,
   target_sort_int_val,
   target_sort_cntry_round_val,
   target_sort_block_round_val,
   target_sort_int_round_val,
   target_proportion_1d_cntry_qty,
   target_proportion_1d_block_qty,
   target_proportion_1d_int_qty,
   target_sort_1d_cntry_val,
   target_sort_1d_cntry_round_val,
   target_sort_1d_block_val,
   target_sort_1d_block_round_val,
   target_sort_1d_int_val,
   target_sort_1d_int_round_val,
   grid_point_sales_ratio_1_qty,
   grid_point_sales_ratio_2_qty,
   grid_point_sales_ratio_3_qty,
   grid_point_sales_ratio_4_qty,
   grid_point_sales_ratio_5_qty,
   grid_point_sales_ratio_6_qty,
   grid_point_sales_ratio_7_qty,
   grid_point_sales_ratio_8_qty,
   grid_point_sales_ratio_9_qty,
   grid_point_sales_ratio_10_qty,
   grid_point_sales_ratio_end_qty,
   grid_point_hours_1_val,
   grid_point_hours_2_val,
   grid_point_hours_3_val,
   grid_point_hours_4_val,
   grid_point_hours_5_val,
   grid_point_hours_6_val,
   grid_point_hours_7_val,
   grid_point_hours_8_val,
   grid_point_hours_9_val,
   grid_point_hours_10_val,
   grid_point_hours_end_val,
   grid_point_hours_end_ian_val,
   cbx_sort_val_null_dq_fg,
   too_large_agg_ian_avq_dq_fg
  FROM p_lew_mart_analytics.t_kol_dataprep_2
;