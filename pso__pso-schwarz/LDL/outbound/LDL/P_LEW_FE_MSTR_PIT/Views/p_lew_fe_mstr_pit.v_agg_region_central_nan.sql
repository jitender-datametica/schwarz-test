/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for V_AGG_REGION_CENTRAL_NAN
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for V_AGG_REGION_CENTRAL_NAN
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-03-20 Prasanna Ranjan	    Initial version
#  1.1  2024-09-24 Prasanna Ranjan	Adjustment Increment 2.1 (PV)
#  1.2  2024-12-17 Nikolai Toknov	Drop column PV_TYPE_ID
#  1.3  2024-12-23 Nikolai Toknov	Rename  MEDIUM_GRP_MSTR_SID_FE_LST -> MEDIUM_GRP_MSTR_SID_LST, MEDIUM_MSTR_SID_FE_LST -> MEDIUM_MSTR_SID_LST
#  1.4  2025-01-14 Nikolai Toknov	Drop columns MEDIUM_IGNORE_FG,MEDIUM_GRP_LIDLPLUS_FG,MEDIUM_ITEM_DISP_FG,MEDIUM_GRP_DRILLDOWN_DISP_FG
#  1.5  2025-03-20 Prasanna Ranjan	Add PV_ON_PV_DESCR and remove REPORTING_LINE CROSS JOIN
#  1.6	2025-05-26 Andreas Kurz		Adding FE MSTR HTML Columns
#  1.7  2026-06-06 Andreas Kurz		Adding 	PRICE_RETAIL_OLD_WEIGHTED_AVG_GROSS, PRICE_RETAIL_NEW_WEIGHTED_AVG_GROSS, and CHEAPER_WEIGHTED_AVG_IN_PCT
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_QS;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

-- LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT
--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
--SELECT GET_DDL('view','P_LEW_FE_MSTR_PIT.V_AGG_REGION_CENTRAL_NAN');
*/

/* 
---------------------------------------------------------------------
Create Access View p_lew_fe_mstr_pit.V_AGG_REGION_CENTRAL_NAN 
------------------------------------------------------------------------
*/




CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_agg_region_central_nan
OPTIONS(DESCRIPTION = `VIEW DIMENSION V_AGG_REGION_CENTRAL_NAN`) AS SELECT AGG.client_id,
 AGG.country_iso_cd,
 AGG.country_descr,
 AGG.warehouse_sid,
 AGG.warehouse_mstr_sid,
 AGG.warehouse_gid,
 AGG.warehouse_mstr_gid,
 AGG.warehouse_name,
 AGG.orig_wh_nr,
 AGG.adv_week_id,
 AGG.adv_week_mstr_id,
 AGG.nearest_rltd_adv_week_fg,
 AGG.adv_week_start_dt,
 AGG.adv_week_end_dt,
 AGG.adv_week_start_dt_descr,
 AGG.adv_week_end_dt_descr,
 AGG.adv_week_start_day_sdescr,
 AGG.adv_week_end_day_sdescr,
 AGG.adv_week_start_day_descr,
 AGG.adv_week_end_day_descr,
 AGG.length_of_adv_week,
 AGG.adv_week_year_id,
 AGG.adv_week_week_nr,
 AGG.adv_week_sdescr,
 AGG.adv_week_descr,
 AGG.adv_week_ldescr,
 AGG.adv_week_overlap_ldescr,
 AGG.prev_1_adv_week_id,
 AGG.next_1_adv_week_id,
 AGG.prev_1_year_adv_week_id,
 AGG.last_adv_week_fg,
 AGG.last_closed_adv_week_fg,
 AGG.mov_adv_week_start_from_current,
 AGG.max_adv_period_end_dt,
 AGG.orig_item_gid,
 AGG.orig_item_mstr_gid,
 AGG.orig_item_nr,
 AGG.orig_item_mstr_nr,
 AGG.dat_valid_from,
 AGG.item_name,
 AGG.item_descr,
 AGG.item_int_descr,
 AGG.item_fam_grp_sid,
 AGG.item_fam_grp_src_id,
 AGG.item_fam_grp_src_cd,
 AGG.item_fam_grp_name,
 AGG.item_fam_grp_descr,
 AGG.item_fam_grp_int_descr,
 AGG.sub_item_grp_gid,
 AGG.sub_item_grp_mstr_gid,
 AGG.sub_item_grp_sid,
 AGG.sub_item_grp_mstr_sid,
 AGG.sub_item_grp_src_cd,
 AGG.sub_item_grp_name,
 AGG.sub_item_grp_descr,
 AGG.sub_item_grp_int_descr,
 AGG.item_grp_int_gid,
 AGG.item_grp_int_mstr_gid,
 AGG.item_grp_int_sid,
 AGG.item_grp_int_mstr_sid,
 AGG.item_grp_int_src_cd,
 AGG.item_grp_int_name,
 AGG.item_grp_int_descr,
 AGG.item_grp_int_int_descr,
 AGG.brand_sid,
 AGG.brand_name,
 AGG.brand_type_cd,
 AGG.buying_list_type_id,
 AGG.buying_list_type_descr,
 AGG.buying_list_type_int_descr,
 AGG.supplier_list_descr,
 AGG.adv_period_id,
 CAST(AGG.adv_period_mstr_id AS STRING) AS adv_period_mstr_id,
 AGG.adv_period_start_dt,
 AGG.adv_period_end_dt,
 AGG.adv_period_start_day_id,
 AGG.adv_period_start_dt_descr,
 AGG.adv_period_end_dt_descr,
 AGG.adv_period_end_day_id,
 AGG.adv_period_start_day_sdescr,
 AGG.adv_period_end_day_sdescr,
 AGG.adv_period_start_day_descr,
 AGG.adv_period_end_day_descr,
 AGG.adv_period_length_in_days,
 AGG.overlap_period_fg,
 AGG.overlap_adv_period_start_dt,
 AGG.overlap_adv_period_end_dt,
 AGG.overlap_adv_week_id,
 AGG.adv_period_descr,
 AGG.adv_period_ldescr,
 AGG.current_adv_period_fg,
 AGG.action_type_id,
 AGG.action_type_sort_val,
 AGG.action_type_name,
 AGG.action_type_descr,
 AGG.pv_on_pv_descr,
 AGG.theme_grp_int_sid,
 AGG.theme_grp_int_mstr_sid,
 AGG.theme_grp_int_name,
 AGG.theme_grp_int_sort_val,
 AGG.theme_grp_nat_sid,
 AGG.theme_grp_nat_mstr_sid,
 AGG.theme_grp_nat_name,
 AGG.theme_grp_nat_sort_val,
 AGG.theme_grp_nat_cat_sid,
 AGG.theme_grp_nat_cat_mstr_sid,
 AGG.theme_grp_nat_cat_name,
 AGG.theme_grp_nat_cat_sort_val,
 AGG.medium_agg_list_descr,
 AGG.medium_grp_agg_list_descr,
 AGG.reporting_line_sid,
 AGG.reporting_line_descr,
 NULL AS medium_grp_drilldown_disp_fg,
 NULL AS medium_mstr_sid_fe_lst,
 AGG.medium_mstr_sid_lst,
 NULL AS medium_grp_mstr_sid_fe_lst,
 AGG.medium_grp_mstr_sid_lst,
 AGG.sort_order_val,
 AGG.add_receipt_cnt,
 AGG.add_receipt_per_store_cnt,
 AGG.add_turnover_net_val,
 AGG.add_turnover_net_per_store_val,
 AGG.add_turnover_qty,
 AGG.add_turnover_per_store_qty,
 AGG.add_turnover_revenue_net_val,
 AGG.adv_item_per_receipt_cnt,
 AGG.add_turnover_revenue_net_per_store_val,
 AGG.adv_receipt_adv_turnover_net_val,
 AGG.adv_receipt_np_turnover_net_val,
 AGG.adv_receipt_total_turnover_net_val,
 AGG.base_receipt_cnt,
 AGG.base_restbon_turnover_net_val,
 AGG.base_turnover_net_val,
 AGG.base_turnover_qty,
 AGG.base_turnover_revenue_net_val,
 AGG.cheaper_max_pct,
 AGG.cheaper_min_pct,
 AGG.cheaper_range,
 AGG.cherry_picker_receipt_cnt,
 AGG.cherry_picker_receipt_cnt_pct,
 AGG.deliv_qty,
 AGG.exclusive_buyer_receipt_cnt,
 AGG.exclusive_buyer_receipt_cnt_pct,
 AGG.heavy_buyer_receipt_cnt,
 AGG.heavy_buyer_receipt_cnt_pct,
 AGG.price_buy_net,
 AGG.price_retail_new_gross_range,
 AGG.price_retail_new_max_gross,
 AGG.price_retail_new_min_gross,
 AGG.price_retail_old_gross_range,
 AGG.price_retail_old_max_gross,
 AGG.price_retail_old_min_gross,
 AGG.price_retail_old_weighted_avg_gross,
 AGG.price_retail_new_weighted_avg_gross,
 AGG.cheaper_weighted_avg_in_pct,
 AGG.pv_effic_revenue_factor,
 AGG.pv_effic_turnover_factor,
 IF(AGG.action_type_id > 10, NULL, AGG.pv_net_val) AS pv_net_val,
 IF(AGG.action_type_id > 10, NULL, AGG.pv_net_val_share_pct) AS pv_net_val_share_pct,
 AGG.pv_lp_net_val,
 AGG.pv_lp_net_val_share_pct,
 AGG.pv_npps_net_val,
 AGG.pv_npps_net_val_share_pct,
 AGG.pv_wawi_net_val,
 AGG.pv_wawi_net_val_share_pct,
 AGG.pv_receipt_cnt_factor,
 AGG.pv_turnover_net_val_factor,
 AGG.pv_turnover_qty_factor,
 AGG.receipt_cnt,
 AGG.receipt_cnt_share_pct,
 AGG.receipt_per_store_cnt,
 AGG.restbon_effect_pct,
 AGG.restbon_np_turnover_net_val,
 AGG.restbon_turnover_net_val,
 AGG.restbon_turnover_revenue_net_val,
 AGG.store_cnt,
 AGG.total_receipt_cnt,
 AGG.total_turnover_net_val,
 IF(AGG.action_type_id > 10, NULL, AGG.turnover_1d_pct) AS turnover_1d_pct,
 AGG.turnover_1d_per_store_qty,
 AGG.turnover_1d_qty,
 IF(AGG.action_type_id > 10, NULL, AGG.turnover_3d_pct) AS turnover_3d_pct,
 AGG.turnover_3d_per_store_qty,
 AGG.turnover_3d_qty,
 IF(AGG.action_type_id > 10, NULL, AGG.turnover_7d_pct) AS turnover_7d_pct,
 AGG.turnover_7d_per_store_qty,
 AGG.turnover_7d_qty,
 IF(AGG.action_type_id > 10, NULL, AGG.turnover_42d_pct) AS turnover_42d_pct,
 AGG.turnover_42d_per_store_qty,
 AGG.turnover_42d_qty,
 AGG.turnover_margin_pct,
 AGG.turnover_net_per_store_val,
 AGG.turnover_net_val,
 AGG.turnover_net_val_share_pct,
 AGG.turnover_pct,
 AGG.turnover_per_store_qty,
 AGG.turnover_qty,
 AGG.turnover_revenue_net_val,
 AGG.turnover_revenue_net_store_val,
 AGG.volume_buy_net_val,
 AGG.reject_fg,
 AGG.reject_reason_id,
 AGG.source_system_id,
 AGG.deleted_fg,
 AGG.dwh_created_ts,
 AGG.dwh_updated_ts,
 AGG.load_id,
 ROW_NUMBER() OVER (PARTITION BY NULL ORDER BY NULL IS NULL, NULL) AS cube_partition_key,
 ldl_p_lew_mart_pit.f_cleanstring(AGG.coupon_agg_list_descr) AS coupon_agg_list_descr_orig,
 CAST(IF(LENGTH(AGG.coupon_agg_list_descr) > 1 AND AGG.action_type_id = 12, 1, 0) AS BIGNUMERIC) AS lp_coupon_list_fg,
 CAST(IF(SAFE_CAST(IF(LENGTH(AGG.coupon_agg_list_descr) > 1 AND AGG.action_type_id = 12, 1, 0) as BIGNUMERIC) = 1, pa.pa301_value || pa.pa302_value || ldl_p_lew_mart_pit.f_formatdstring_html(AGG.coupon_agg_list_descr) || pa.pa303_value, NULL) AS STRING)
 AS lp_coupon_html_table_tag,
 ldl_p_lew_mart_pit.f_formatstring_ascii(AGG.coupon_agg_list_descr) AS lp_coupon_agg_list_ascii_descr,
 CAST(IF(SAFE_CAST(IF(LENGTH(AGG.coupon_agg_list_descr) > 1 AND AGG.action_type_id = 12, 1, 0) as BIGNUMERIC) = 1, '<p> LP Coupons f&uuml;r: ' || AGG.item_name || ' ( ' || SAFE_CAST(AGG.orig_item_nr as STRING) || ' ) und WerbeWoche ' || SAFE_CAST(AGG.adv_week_descr as STRING) || '</p>', NULL) AS
  STRING) AS lp_coupon_title_display,
 CAST(IF(SAFE_CAST(IF(LENGTH(AGG.coupon_agg_list_descr) > 1 AND AGG.action_type_id = 12, 1, 0) as BIGNUMERIC) = 1, AGG.orig_item_mstr_gid, NULL) AS BIGNUMERIC)
 AS lp_copuon_text_display_id,
 CAST(IF(SAFE_CAST(IF(LENGTH(AGG.coupon_agg_list_descr) > 1 AND AGG.action_type_id = 12, 1, 0) as BIGNUMERIC) = 1, REPLACE(REPLACE(ldl_p_lew_mart_pit.f_formatstring_ascii(REPLACE(REPLACE(REPLACE(pa.pa300_value, '#LP_COUPON_TITLE_DISPLAY#', SAFE_CAST(IF(SAFE_CAST(IF(LENGTH(AGG.coupon_agg_list_descr) > 1
               AND AGG.action_type_id = 12, 1, 0) as BIGNUMERIC) = 1, '<p> LP Coupons f&uuml;r: ' || AGG.item_name || ' ( ' || SAFE_CAST(AGG.orig_item_nr as STRING) || ' ) und WerbeWoche ' || SAFE_CAST(AGG.adv_week_descr as STRING) || '</p>', NULL) as STRING)), '#LP_COUPON_AGG_LIST_ASCII_DESCR#',
        SAFE_CAST(ldl_p_lew_mart_pit.f_formatstring_ascii(AGG.coupon_agg_list_descr) as STRING)), '#LP_COUPON_HEADER_TEXT#', pa.pa304_value)), '<p>', ''), '</p>', ''), NULL) AS STRING)
 AS img_info_html_tag,
 CAST(IF(SAFE_CAST(IF(LENGTH(AGG.coupon_agg_list_descr) > 1 AND AGG.action_type_id = 12, 1, 0) as BIGNUMERIC) = 1, SAFE_CAST(IF(SAFE_CAST(IF(LENGTH(AGG.coupon_agg_list_descr) > 1 AND AGG.action_type_id = 12, 1, 0) as BIGNUMERIC) = 1, REPLACE(REPLACE(ldl_p_lew_mart_pit.f_formatstring_ascii(REPLACE(REPLACE(REPLACE(pa
           .pa300_value, '#LP_COUPON_TITLE_DISPLAY#', SAFE_CAST(IF(SAFE_CAST(IF(LENGTH(AGG.coupon_agg_list_descr) > 1 AND AGG.action_type_id = 12, 1, 0) as BIGNUMERIC) = 1, '<p> LP Coupons f&uuml;r: ' || AGG.item_name || ' ( ' || SAFE_CAST(AGG.orig_item_nr as STRING) || ' ) und WerbeWoche ' ||
               SAFE_CAST(AGG.adv_week_descr as STRING) || '</p>', NULL) as STRING)), '#LP_COUPON_AGG_LIST_ASCII_DESCR#', SAFE_CAST(ldl_p_lew_mart_pit.f_formatstring_ascii(AGG.coupon_agg_list_descr) as STRING)), '#LP_COUPON_HEADER_TEXT#', pa.pa304_value)), '<p>', ''), '</p>', ''), NULL) as STRING), NULL
   ) AS STRING) AS lp_copuon_text_display_descr
FROM ldl_p_lew_fe_mstr_pit.t_agg_region_central_nan AS AGG
 INNER JOIN (SELECT MAX(CASE
     WHEN fe_mstr_param_id = 300
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa300_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 301
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa301_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 302
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa302_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 303
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa303_value,
   MAX(CASE
     WHEN fe_mstr_param_id = 304
     THEN fe_mstr_param_value
     ELSE NULL
     END) AS pa304_value
  FROM ldl_p_lew_fe_mstr_pit.t_cntl_fe_mstr_param
  WHERE CURRENT_DATE BETWEEN valid_from_dt AND valid_to_dt
   AND reject_fg = 0
   AND deleted_fg = 0
   AND current_fg = 1) AS pa ON TRUE
WHERE AGG.deleted_fg = 0
 AND AGG.reject_fg = 0;

