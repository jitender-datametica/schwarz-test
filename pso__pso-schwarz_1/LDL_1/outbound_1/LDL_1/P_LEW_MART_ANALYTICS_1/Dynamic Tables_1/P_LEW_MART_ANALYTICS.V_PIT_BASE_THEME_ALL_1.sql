CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_analytics.v_pit_base_theme_all_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT client_id,
 adv_week_id,
 CAST(adv_week_id * 100 + client_id AS BIGNUMERIC) AS adv_week_sid,
 33 AS hier_level_id,
 '2#X' AS sort_order_val,
 CAST(- 2 AS BIGNUMERIC) AS adv_theme_sid,
 CAST(- 2 * 100 + client_id AS BIGNUMERIC) AS adv_theme_mstr_sid,
   COALESCE(advert_items_pv_cnt, 0) + COALESCE(advert_items_nf_cnt, 0) + COALESCE(advert_items_fa_cnt, 0) AS
 advert_items_cnt,
 COALESCE(advert_items_pv_cnt, 0) AS advert_items_pv_cnt,
 COALESCE(advert_items_nf_cnt, 0) AS advert_items_nf_cnt,
 COALESCE(advert_items_fa_cnt, 0) AS advert_items_fa_cnt,
 stores_cnt,
 receipts_cnt,
 sales_net_val,
 sales_buy_price_net_val,
 total_receipts_cnt,
 total_sales_net_val
FROM ldl_p_lew_mart_analytics.t_advert_week_theme_total_1 AS VT
WHERE 33 = 33
UNION ALL
SELECT VT.client_id,
 VT.adv_week_id,
 CAST(VT.adv_week_id * 100 + VT.client_id AS BIGNUMERIC) AS adv_week_sid,
 32 AS hier_level_id,
  '1#' || TH.adv_theme_descr AS sort_order_val,
 VT.adv_theme_sid,
 CAST(VT.adv_theme_sid * 100 + VT.client_id AS BIGNUMERIC) AS adv_theme_mstr_sid,
   COALESCE(VT.advert_items_pv_cnt, 0) + COALESCE(VT.advert_items_nf_cnt, 0) + COALESCE(VT.advert_items_fa_cnt, 0) AS
 advert_items_cnt,
 COALESCE(VT.advert_items_pv_cnt, 0) AS advert_items_pv_cnt,
 COALESCE(VT.advert_items_nf_cnt, 0) AS advert_items_nf_cnt,
 COALESCE(VT.advert_items_fa_cnt, 0) AS advert_items_fa_cnt,
 VT.stores_cnt,
 VT.receipts_cnt,
 VT.sales_net_val,
 VT.sales_buy_price_net_val,
 VT.total_receipts_cnt,
 VT.total_sales_net_val
FROM ldl_p_lew_mart_analytics.t_advert_week_theme_1 AS VT
 INNER JOIN ldl_p_lew_mart_analytics.t_advert_theme_1 AS TH ON VT.client_id = TH.client_id AND VT.adv_theme_sid = TH.adv_theme_sid
   
WHERE 32 = 32;