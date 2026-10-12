CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_wawi_inv_item_wh_ejr AS
SELECT agg.client_id,
 agg.wh_id,
 agg.inv_id,
 agg.inv_start_date,
 agg.inv_end_date,
 agg.item_id,
  agg.val_rtl_ejr_asis / B.rate_currency_exchange AS val_rtl_ejr_asis,
  agg.val_rtl_net_ejr_asis / B.rate_currency_exchange AS val_rtl_net_ejr_asis,
  agg.val_return_ejr_asis / B.rate_currency_exchange AS val_return_ejr_asis,
  agg.val_return_net_ejr_asis / B.rate_currency_exchange AS val_return_net_ejr_asis,
 B.currency_iso_cd
FROM (SELECT INV.client_id,
   WH.wh_id,
   INV.inv_id,
   DATE_ADD(INV.prev_dat_formdate, INTERVAL 1 DAY) AS inv_start_date,
   INV.dat_formdate AS inv_end_date,
   NET.item_sid AS item_id,
   SUM(NET.sales_gross_val) AS val_rtl_ejr_asis,
   SUM(NET.sales_net_val) AS val_rtl_net_ejr_asis,
   SUM(NET.return_gross_val) AS val_return_ejr_asis,
   SUM(NET.return_net_val) AS val_return_net_ejr_asis
  FROM ldl_p_lew_core_ac.v_wawi_inv_item_wh_prev_dat AS INV
   INNER JOIN ldl_p_lew_core_ac.v_location AS L ON INV.client_id = L.client_id AND INV.wh_loc_sid = L.loc_sid
   INNER JOIN ldl_p_lew_mart_msi.v_org_wh AS WH ON L.client_id = WH.client_id AND L.src_wh_id = WH.wh_id
   INNER JOIN ldl_p_lew_bil_ac.v_agg_pos_wh_day_item_asis AS NET ON INV.client_id = NET.client_id AND INV.wh_loc_sid =
      NET.loc_sid_wh AND NET.dwh_cal_dt BETWEEN DATE_ADD(INV.prev_dat_formdate, INTERVAL 1 DAY) AND INV.dat_formdate
  GROUP BY INV.client_id,
   WH.wh_id,
   INV.inv_id,
   inv_start_date,
   inv_end_date,
   item_id) AS agg
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS B ON agg.client_id = B.client_id AND CURRENT_DATE
   BETWEEN B.dat_rec_start AND B.dat_rec_end;