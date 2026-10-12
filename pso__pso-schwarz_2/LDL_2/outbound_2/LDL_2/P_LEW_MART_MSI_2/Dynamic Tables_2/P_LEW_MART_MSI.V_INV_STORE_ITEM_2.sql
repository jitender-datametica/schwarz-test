
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_inv_store_item_2
AS
SELECT STO.client_id,
 STO.st_loc_sid AS store_id,
 STO.item_sid AS item_id,
 STO.dat_dayend,
 STO.inv_id,
 WH.src_wh_id AS wh_id,
 STO.vat_id,
 STO.order_area_cd,
 STO.pos_nr,
 STO.weight_fg,
 STO.qty_case_inv,
 STO.qty_piece_inv,
 STO.qty_case_inv_new,
 STO.qty_piece_inv_new,
 STO.pricegroup_wh,
 STO.pricegroup_store,
  STO.price_retail_inv / CRY.rate_currency_exchange AS price_retail_inv,
  STO.price_retail_net_inv / CRY.rate_currency_exchange AS price_retail_net_inv,
  STO.price_retail_inv_wh / CRY.rate_currency_exchange AS price_retail_inv_wh,
  STO.price_retail_net_inv_wh / CRY.rate_currency_exchange AS price_retail_net_inv_wh,
 STO.comment_inv,
 STO.status_inv,
 STO.case_size_dec,
 CRY.currency_iso_cd
FROM ldl_p_lew_core_ac.v_wawi_inv_store_item_2 AS STO
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON STO.client_id = WH.client_id AND STO.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_inv_store_2 AS H ON STO.client_id = H.client_id AND STO.st_loc_sid = H.st_loc_sid AND
       STO.wh_loc_sid = H.wh_loc_sid AND STO.inv_id = H.inv_id AND STO.dat_dayend = H.dat_dayend AND H.inv_fg = 71 AND H
   .status_inv_sic = 64
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON STO.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;

