CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_KOL_GRID_POINT_2
(
      client_id
    , item_ian
    , adv_dt
    , range_plan_cd
    , country_cbx_cd
    , ean_clean
    , sales_ratio_1_qty
    , sales_ratio_2_qty
    , sales_ratio_3_qty
    , sales_ratio_4_qty
    , sales_ratio_5_qty
    , sales_ratio_6_qty
    , sales_ratio_7_qty
    , sales_ratio_8_qty
    , sales_ratio_9_qty
    , sales_ratio_10_qty
    , sales_ratio_end_qty
    , hours_since_adv_corr_1_val
    , hours_since_adv_corr_2_val
    , hours_since_adv_corr_3_val
    , hours_since_adv_corr_4_val
    , hours_since_adv_corr_5_val
    , hours_since_adv_corr_6_val
    , hours_since_adv_corr_7_val
    , hours_since_adv_corr_8_val
    , hours_since_adv_corr_9_val
    , hours_since_adv_corr_10_val
    , hours_until_end_corr_val
    , opening_hours_missing_dq_fg
    , sales_qty_null_dq_fg
    , delivery_qty_ian_null_dq_fg
    , delivery_qty_ean_null_dq_fg
    , hours_until_end_corr_ian_val
)
AS
   SELECT
         client_id,
   item_ian,
   adv_dt,
   range_plan_cd,
   country_cbx_cd,
   ean_clean,
   sales_ratio_1_qty,
   sales_ratio_2_qty,
   sales_ratio_3_qty,
   sales_ratio_4_qty,
   sales_ratio_5_qty,
   sales_ratio_6_qty,
   sales_ratio_7_qty,
   sales_ratio_8_qty,
   sales_ratio_9_qty,
   sales_ratio_10_qty,
   sales_ratio_end_qty,
   hours_since_adv_corr_1_val,
   hours_since_adv_corr_2_val,
   hours_since_adv_corr_3_val,
   hours_since_adv_corr_4_val,
   hours_since_adv_corr_5_val,
   hours_since_adv_corr_6_val,
   hours_since_adv_corr_7_val,
   hours_since_adv_corr_8_val,
   hours_since_adv_corr_9_val,
   hours_since_adv_corr_10_val,
   hours_until_end_corr_val,
   opening_hours_missing_dq_fg,
   sales_qty_null_dq_fg,
   delivery_qty_ian_null_dq_fg,
   delivery_qty_ean_null_dq_fg,
   hours_until_end_corr_ian_val
  FROM p_lew_mart_analytics.t_kol_grid_point_2
;