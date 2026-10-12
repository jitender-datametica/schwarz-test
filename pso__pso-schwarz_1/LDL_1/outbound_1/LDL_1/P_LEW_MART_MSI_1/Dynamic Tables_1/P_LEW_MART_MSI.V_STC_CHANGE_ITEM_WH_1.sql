CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_stc_change_item_wh_1 AS
SELECT SCIH.client_id,
 WH.src_wh_id AS wh_id,
 SCIH.item_sid AS item_id,
 SCIH.dat_formdate,
 SCIH.inv_id_stc_change,
 SCIH.stc_change_type_cd,
 SCIH.qty_piece_stc_change,
  SCIH.price_retail_stc_change / CRY.rate_currency_exchange AS price_retail_stc_change,
  SCIH.price_retail_net_stc_change / CRY.rate_currency_exchange AS price_retail_net_stc_change,
 CRY.currency_iso_cd -- , cry.rate_currency_exchange

FROM ldl_p_lew_core_ac.v_wawi_stc_change_item_wh_1 AS SCIH
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON SCIH.client_id = WH.client_id AND SCIH.wh_loc_sid = WH.loc_sid_wh AND
   WH.dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON SCIH.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;