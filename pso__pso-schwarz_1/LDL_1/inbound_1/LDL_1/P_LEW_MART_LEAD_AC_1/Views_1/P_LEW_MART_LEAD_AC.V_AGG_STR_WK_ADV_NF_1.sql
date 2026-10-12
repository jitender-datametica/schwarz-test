CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STR_WK_ADV_NF_1
(
  client_id
, loc_sid_store_move_to
, cy_week_partial_week_id
, nf_val_adv_1_sales_1_day
, nf_val_adv_1_sales_3_day
, nf_val_adv_1_sales_7_day
, nf_val_adv_2_sales_1_day
, nf_val_adv_2_sales_3_day
, nf_val_adv_2_sales_7_day
, nf_val_adv_3_sales_1_day
, nf_val_adv_3_sales_3_day
, nf_val_adv_3_sales_7_day
, nf_val_adv_sales_1_day_wk
, nf_val_adv_sales_3_day_wk
, nf_val_adv_sales_7_day_wk
, nf_val_adv_sales_1_day_wk_p1y
, nf_val_adv_sales_3_day_wk_p1y
, nf_val_adv_sales_7_day_wk_p1y
, nf_val_adv_sales_1_day_mtd
, nf_val_adv_sales_3_day_mtd
, nf_val_adv_sales_7_day_mtd
, nf_val_adv_sales_1_day_mtd_p1y
, nf_val_adv_sales_3_day_mtd_p1y
, nf_val_adv_sales_7_day_mtd_p1y
, nf_val_adv_sales_1_day_bytd
, nf_val_adv_sales_3_day_bytd
, nf_val_adv_sales_7_day_bytd
, nf_val_adv_sales_1_day_bytd_p1y
, nf_val_adv_sales_3_day_bytd_p1y
, nf_val_adv_sales_7_day_bytd_p1y
, timestamp_mod
)
AS

   SELECT
     client_id,
   loc_sid_store_move_to,
   cy_week_partial_week_id,
   nf_val_adv_1_sales_1_day,
   nf_val_adv_1_sales_3_day,
   nf_val_adv_1_sales_7_day,
   nf_val_adv_2_sales_1_day,
   nf_val_adv_2_sales_3_day,
   nf_val_adv_2_sales_7_day,
   nf_val_adv_3_sales_1_day,
   nf_val_adv_3_sales_3_day,
   nf_val_adv_3_sales_7_day,
   nf_val_adv_sales_1_day_wk,
   nf_val_adv_sales_3_day_wk,
   nf_val_adv_sales_7_day_wk,
   nf_val_adv_sales_1_day_wk_p1y,
   nf_val_adv_sales_3_day_wk_p1y,
   nf_val_adv_sales_7_day_wk_p1y,
   nf_val_adv_sales_1_day_mtd,
   nf_val_adv_sales_3_day_mtd,
   nf_val_adv_sales_7_day_mtd,
   nf_val_adv_sales_1_day_mtd_p1y,
   nf_val_adv_sales_3_day_mtd_p1y,
   nf_val_adv_sales_7_day_mtd_p1y,
   nf_val_adv_sales_1_day_bytd,
   nf_val_adv_sales_3_day_bytd,
   nf_val_adv_sales_7_day_bytd,
   nf_val_adv_sales_1_day_bytd_p1y,
   nf_val_adv_sales_3_day_bytd_p1y,
   nf_val_adv_sales_7_day_bytd_p1y,
   timestamp_mod
  FROM p_lew_mart_lead.t_agg_str_wk_adv_nf_1
;