
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_inv_store_item_corr_2
AS
SELECT SIC.client_id,
 SIC.inv_id,
 SIC.item_sid AS item_id,
 SIC.st_loc_sid AS store_id,
 WH.src_wh_id AS wh_id,
 SIC.order_area_cd,
 SIC.dat_dayend,
 SIC.pos_nr,
 SIC.weight_fg,
  SIC.price_retail_inv_item_corr / CRY.rate_currency_exchange AS price_retail_inv_item_corr,
  SIC.price_retail_new_inv_item_corr / CRY.rate_currency_exchange AS price_retail_new_inv_item_corr,
  SIC.price_rtl_net_inv_item_corr / CRY.rate_currency_exchange AS price_retail_net_inv_item_corr,
  SIC.prc_rtl_new_net_inv_item_corr / CRY.rate_currency_exchange AS prc_rtl_new_net_inv_item_corr,
 SIC.qty_case_inv_item_corr,
 SIC.qty_case_new_inv_item_corr,
 SIC.qty_piece_inv_item_corr,
 SIC.qty_piece_new_inv_item_corr,
 SIC.case_size_dec,
 CRY.currency_iso_cd -- ,cry.rate_currency_exchange

FROM ldl_p_lew_core_ac.v_wawi_inv_store_item_corr_2 AS SIC
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON SIC.client_id = WH.client_id AND SIC.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_inv_store_2 AS H ON SIC.client_id = H.client_id AND SIC.st_loc_sid = H.st_loc_sid AND
       SIC.wh_loc_sid = H.wh_loc_sid AND SIC.inv_id = H.inv_id AND SIC.dat_dayend = H.dat_dayend AND H.inv_fg = 71 AND H
   .status_inv_sic = 64
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON SIC.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;


