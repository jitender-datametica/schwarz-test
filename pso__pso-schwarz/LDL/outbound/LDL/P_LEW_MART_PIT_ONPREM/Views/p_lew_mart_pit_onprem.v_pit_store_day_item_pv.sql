CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_store_day_item_pv (client_id, store_sid, store_name, city_name,
dwh_cal_dt, weekday_nr, weekday_descr, weekday_sdescr, dwh_cal_dt_ldescr, cy_month, cy_month_descr, action_type_id,
adv_week_id, assigned_pv_start_dt, assigned_pv_end_dt, assigned_pv_period_descr, adv_period_nr_of_days, adv_period_id,
apt_promotion_start_dt, apt_promotion_end_dt, apt_adv_period_id, pv_adv_period_id, comp_assigned_pv_start_dt,
comp_assigned_pv_end_dt, item_sid, item_mstr_sid, orig_item_nr, item_descr_int, item_descr, sub_item_grp_sid,
src_subitemgrp_id, src_subitemgrp_cd, sub_item_grp_name, item_fam_grp_sid, src_familygrp_id, src_familygrp_cd,
item_fam_grp_name, item_fam_grp_descr, item_grp_int_sid, src_itemgrp_int_id, src_itemgrp_int_cd, item_grp_int_name,
item_grp_int_descr, brand_sid, brand_name_int, brand_descr, buying_list_type_id, buying_list_type_descr,
buying_list_type_group_id, buying_list_type_group_descr, listing_type_id, listing_type_descr, listing_type_group_id,
listing_type_group_descr, listing_fg, marke_em_descr, em_fg, marke_fg, case_size, sales_qty, receipts_cnt, sales_net_val
, base_sales_net_val, total_sales_net_val, total_pv_sales_net_val, total_sales_net_val_pct, sales_price_net_old,
sales_price_old, sales_price_net_new, sales_price_new, sales_price_p1_day, sales_price_p7_max_days,
sales_price_p14_max_days, sales_price_median_day, sales_price_old_median_day, store_cnt, store_cnt_month, store_cnt_pv,
pv_event_fg, pv_rule_1_state, pv_rule_2_state, pv_rule_3_state, pv_active_fg, pv_restricted_stores_fg, fa_nf_action_fg,
pv_split_fg, orig_adv_week_id, pv_sunday_open_fg, local_price_fg, pit_price_integrity_fg, vat_pct_val, vat_factor,
base_receipts_cnt, base_sales_qty, regular_nr_of_stores_per_item_day, pv_nr_of_stores_per_item_day, pv_value,
price_diff_pct, pv_fg, pv_local_fg, add_pv_sales_net_val, pv_effect_pct, store_cnt_fg, nr_of_stores_per_item_day_pct,
sales_net_pv_factor, add_pv_receipts_cnt, receipts_cnt_pv_factor, sales_qty_pv_factor, add_pv_sales_net_val_per_store,
apt_only_fg) AS SELECT PVM.client_id,
 PVM.store_sid,
 COALESCE(STR.store_name, 'N/A') AS store_name,
 COALESCE(STR.city_name, 'N/A') AS city_name,
 PVM.dwh_cal_dt,
 CAST(FORMAT_DATE('%u', DATE(PVM.dwh_cal_dt)) AS INTEGER) AS weekday_nr,
 FORMAT_DATE('%a', DATE(PVM.dwh_cal_dt)) AS weekday_descr,
 FORMAT_DATE('%a', DATE(PVM.dwh_cal_dt)) AS weekday_sdescr,
 FORMAT_DATE('%a, %b %d , %Y', DATE(PVM.dwh_cal_dt)) AS dwh_cal_dt_ldescr,
 ROUND(SAFE_CAST(FORMAT_DATE('%Y%m', DATE(PVM.dwh_cal_dt)) AS BIGNUMERIC), 0) AS cy_month,
 FORMAT_DATE('%b-%Y', DATE(PVM.dwh_cal_dt)) AS cy_month_descr,
 1 AS action_type_id,
 PVM.adv_week_id,
 PVM.assigned_pv_start_dt,
 PVM.assigned_pv_end_dt,
   FORMAT_DATE('%a', PVM.assigned_pv_start_dt) || ' - ' || FORMAT_DATE('%a', PVM.assigned_pv_end_dt) AS
 assigned_pv_period_descr,
 CAST(DATE_DIFF(PVM.assigned_pv_end_dt, PVM.assigned_pv_start_dt, DAY) + 1 AS BIGNUMERIC) AS adv_period_nr_of_days,
 PVM.adv_period_id,
 PVM.apt_promotion_start_dt,
 PVM.apt_promotion_end_dt,
 PVM.apt_adv_period_id,
 PVM.pv_adv_period_id,
 PVM.comp_assigned_pv_start_dt,
 PVM.comp_assigned_pv_end_dt,
 PVM.item_sid,
 CAST(ITM.item_sid * 100 + ITM.client_id AS BIGNUMERIC) AS item_mstr_sid,
 ITM.orig_item_nr,
 ITM.item_descr_int,
 ITM.item_descr,
 ITM.sub_item_grp_sid,
 ITM.src_subitemgrp_id,
 ITM.src_subitemgrp_cd,
 ITM.sub_item_grp_name,
 ITM.item_fam_grp_sid,
 ITM.src_familygrp_id,
 ITM.src_familygrp_cd,
 ITM.item_fam_grp_name,
 ITM.item_fam_grp_descr,
 ITM.item_grp_int_sid,
 ITM.src_itemgrp_int_id,
 ITM.src_itemgrp_int_cd,
 ITM.item_grp_int_name,
 ITM.item_grp_int_descr,
 ITM.brand_sid,
 ITM.brand_name_int,
 ITM.brand_descr,
 ITM.buying_list_type_id,
 ITM.buying_list_type_descr,
 ITM.buying_list_type_group_id,
 ITM.buying_list_type_group_descr,
 ITM.listing_type_id,
 ITM.listing_type_descr,
 ITM.listing_type_group_id,
 ITM.listing_type_group_descr,
 ITM.listing_fg,
 ITM.marke_em_descr,
 ITM.em_fg,
 ITM.marke_fg,
 ITM.case_size,
 PVM.sales_qty,
 PVM.receipts_cnt,
 PVM.sales_net_val,
 PVM.base_sales_net_val,
 PVM.total_sales_net_val,
 PVM.total_pv_sales_net_val,
  IF(PVM.total_pv_sales_net_val = 0, 0, SAFE_DIVIDE(PVM.total_sales_net_val, PVM.total_pv_sales_net_val)) * 100 AS
 total_sales_net_val_pct,
 PVM.sales_price_old AS sales_price_net_old,
  PVM.sales_price_old * (1.00 + PVM.vat_factor) AS sales_price_old,
 PVM.sales_price AS sales_price_net_new,
  PVM.sales_price * (1.00 + PVM.vat_factor) AS sales_price_new,
 PVM.sales_price_p1_day,
 PVM.sales_price_p7_max_days,
 PVM.sales_price_p14_max_days,
 PVM.sales_price_median_day,
 PVM.sales_price_old_median_day,
 PVM.store_cnt,
 PVM.store_cnt_month,
 PVM.store_cnt_pv,
 PVM.pv_event_fg,
 PVM.pv_rule_1_state,
 PVM.pv_rule_2_state,
 PVM.pv_rule_3_state,
 PVM.pv_active_fg,
 PVM.pv_restricted_stores_fg,
 PVM.fa_nf_action_fg,
 PVM.pv_split_fg,
 PVM.orig_adv_week_id,
 PVM.pv_sunday_open_fg,
 PVM.local_price_fg,
 PVM.pit_price_integrity_fg,
 PVM.vat_pct_val,
 PVM.vat_factor,
 PVM.base_receipts_cnt,
 PVM.base_sales_qty,
 PVM.regular_nr_of_stores_per_item_day,
 PVM.pv_nr_of_stores_per_item_day,
 ROUND(CAST((PVM.sales_price - PVM.sales_price_old) * PVM.sales_qty AS BIGNUMERIC), 5) AS pv_value,
 CAST(PVM.sales_price / CASE
     WHEN PVM.sales_price_old = 0
     THEN NULL
     ELSE PVM.sales_price_old
     END - 1 AS BIGNUMERIC) AS price_diff_pct,
  CASE
  WHEN PVM.pv_active_fg = 1 AND PVM.pv_restricted_stores_fg = 0 AND PVM.fa_nf_action_fg = 0 AND PVM.pv_sunday_open_fg =
    0
  THEN 1
  ELSE 0
  END AS pv_fg,
  CASE
  WHEN PVM.pv_active_fg = 1 AND PVM.pv_restricted_stores_fg = 1 AND PVM.fa_nf_action_fg = 0 AND PVM.pv_sunday_open_fg =
    0
  THEN 1
  ELSE 0
  END AS pv_local_fg,
 CAST(PVM.sales_net_val - PVM.base_sales_net_val AS BIGNUMERIC) AS add_pv_sales_net_val,
 CAST((CAST(PVM.sales_net_val - PVM.base_sales_net_val AS BIGNUMERIC) / CASE
       WHEN - 1.00 * ROUND(CAST((PVM.sales_price - PVM.sales_price_old) * PVM.sales_qty AS BIGNUMERIC), 5) = 0
       THEN NULL
       ELSE - 1.00 * ROUND(CAST((PVM.sales_price - PVM.sales_price_old) * PVM.sales_qty AS BIGNUMERIC), 5)
       END - 1.00) * 100 AS BIGNUMERIC) AS pv_effect_pct,
  CASE
  WHEN ROUND(CAST(TRUNC(CAST(CAST(PVM.store_cnt AS NUMERIC) / CASE
         WHEN CAST(PVM.store_cnt_month AS NUMERIC) = 0
         THEN NULL
         ELSE CAST(PVM.store_cnt_month AS NUMERIC)
         END AS BIGNUMERIC)) AS BIGNUMERIC), 5) >= pa.pv_sunday_open_threshold
  THEN 1
  ELSE 0
  END AS store_cnt_fg,
 CAST(CAST(PVM.pv_nr_of_stores_per_item_day AS BIGNUMERIC) / CASE
    WHEN CAST(PVM.regular_nr_of_stores_per_item_day AS BIGNUMERIC) = 0
    THEN NULL
    ELSE CAST(PVM.regular_nr_of_stores_per_item_day AS BIGNUMERIC)
    END AS BIGNUMERIC) AS nr_of_stores_per_item_day_pct,
 CAST(PVM.sales_net_val / CASE
    WHEN PVM.base_sales_net_val = 0
    THEN NULL
    ELSE PVM.base_sales_net_val
    END AS BIGNUMERIC) AS sales_net_pv_factor,
  PVM.receipts_cnt - PVM.base_receipts_cnt AS add_pv_receipts_cnt,
 ROUND(CAST(PVM.receipts_cnt / CASE
     WHEN PVM.base_receipts_cnt = 0
     THEN NULL
     ELSE PVM.base_receipts_cnt
     END AS BIGNUMERIC), 5) AS receipts_cnt_pv_factor,
 CAST(PVM.sales_qty / CASE
    WHEN PVM.base_sales_qty = 0
    THEN NULL
    ELSE PVM.base_sales_qty
    END AS BIGNUMERIC) AS sales_qty_pv_factor,
 ROUND(CAST(TRUNC(CAST(CAST(PVM.sales_net_val - PVM.base_sales_net_val AS BIGNUMERIC) / CASE
       WHEN CAST(PVM.store_cnt AS BIGNUMERIC) = 0
       THEN NULL
       ELSE CAST(PVM.store_cnt AS BIGNUMERIC)
       END AS BIGNUMERIC)) AS BIGNUMERIC), 5) AS add_pv_sales_net_val_per_store,
 PVM.apt_only_fg
FROM ldl_p_lew_mart_pit_onprem.t_pit_store_day_item_pv AS PVM
 INNER JOIN (SELECT client_id,
   MAX(`A118612`) AS pv_sunday_open_threshold
  FROM (SELECT client_id,
     IF(param_id = 2, SAFE_CAST(param_value as BIGNUMERIC), NULL) AS `A118612`
    FROM ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param
    WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
     AND deleted_fg = 0
    QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY CAST(client_id AS STRING), CAST(param_id AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t1
  GROUP BY client_id) AS pa ON PVM.client_id = pa.client_id
 INNER JOIN ldl_p_lew_mart_pit_onprem.v_pit_item_client_day_hist AS ITM ON PVM.client_id = ITM.client_id AND PVM.item_sid
     = ITM.item_sid AND PVM.dwh_cal_dt = ITM.dwh_cal_dt
 LEFT JOIN ldl_p_lew_bil_ac.v_dim_store AS STR ON PVM.client_id = STR.client_id AND PVM.store_sid = STR.store_sid;