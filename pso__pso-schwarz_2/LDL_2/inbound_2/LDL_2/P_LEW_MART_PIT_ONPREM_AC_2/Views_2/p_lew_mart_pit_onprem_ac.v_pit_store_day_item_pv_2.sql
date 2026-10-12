CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_STORE_DAY_ITEM_PV_2
AS
SELECT
      client_id
    
, store_sid
    
, store_name
    
, city_name
    
, dwh_cal_dt
    
, weekday_nr
    
, weekday_descr
    
, weekday_sdescr
    
, dwh_cal_dt_ldescr
    
, cy_month
    
, cy_month_descr
    
, action_type_id
    
, adv_week_id
    
, assigned_pv_start_dt
    
, assigned_pv_end_dt
    
, assigned_pv_period_descr
    
, adv_period_nr_of_days
    
, adv_period_id
    
, apt_promotion_start_dt
    
, apt_promotion_end_dt
    
, apt_adv_period_id
    
, pv_adv_period_id
    
, comp_assigned_pv_start_dt
    
, comp_assigned_pv_end_dt
    
, item_sid
    
, item_mstr_sid
    
, orig_item_nr
    
, item_descr_int
    
, item_descr
    
, sub_item_grp_sid
    
, src_subitemgrp_id
    
, src_subitemgrp_cd
    
, sub_item_grp_name
    
, item_fam_grp_sid
    
, src_familygrp_id
    
, src_familygrp_cd
    
, item_fam_grp_name
    
, item_fam_grp_descr
    
, item_grp_int_sid
    
, src_itemgrp_int_id
    
, src_itemgrp_int_cd
    
, item_grp_int_name
    
, item_grp_int_descr
    
, brand_sid
    
, brand_name_int
    
, brand_descr
    
, buying_list_type_id
    
, buying_list_type_descr
    
, buying_list_type_group_id
    
, buying_list_type_group_descr
    
, listing_type_id
    
, listing_type_descr
    
, listing_type_group_id
    
, listing_type_group_descr
    
, listing_fg
    
, marke_em_descr
    
, em_fg
    
, marke_fg
    
, case_size
    
, sales_qty
    
, receipts_cnt
    
, sales_net_val
    
, base_sales_net_val
    
, total_sales_net_val
    
, total_pv_sales_net_val
    
, total_sales_net_val_pct
    
, sales_price_net_old
    
, sales_price_old
    
, sales_price_net_new
    
, sales_price_new
    
, sales_price_p1_day
    
, sales_price_p7_max_days
    
, sales_price_p14_max_days
    
, sales_price_median_day
    
, sales_price_old_median_day
    
, store_cnt
    
, store_cnt_month
    
, store_cnt_pv
    
, pv_event_fg
    
, pv_rule_1_state
    
, pv_rule_2_state
    
, pv_rule_3_state
    
, pv_active_fg
    
, pv_restricted_stores_fg
    
, fa_nf_action_fg
    
, pv_split_fg
    
, orig_adv_week_id
    
, pv_sunday_open_fg
    
, local_price_fg
    
, pit_price_integrity_fg
    
, vat_pct_val
    
, vat_factor
    
, base_receipts_cnt
    
, base_sales_qty
    
, regular_nr_of_stores_per_item_day
    
, pv_nr_of_stores_per_item_day
    
, pv_value
    
, price_diff_pct
    
, pv_fg
    
, pv_local_fg
    
, add_pv_sales_net_val
    
, pv_effect_pct
    
, store_cnt_fg
    
, nr_of_stores_per_item_day_pct
    
, sales_net_pv_factor
    
, add_pv_receipts_cnt
    
, receipts_cnt_pv_factor
    
, sales_qty_pv_factor
    
, add_pv_sales_net_val_per_store
    
, apt_only_fg
FROM p_lew_mart_pit_onprem.v_pit_store_day_item_pv_2;