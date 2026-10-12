CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_stc_item_nfb_wh_1 AS
SELECT SINW.client_id,
 WH.src_wh_id AS wh_id,
 SINW.item_sid AS item_id,
 SINW.dat_formdate,
 SINW.pos_nr,
 SINW.pos_nr_link,
 SINW.nfb_type_cd,
 SINW.qty_case_nfb,
  SINW.price_retail / CRY.rate_currency_exchange AS price_retail,
  SINW.price_retail_net / CRY.rate_currency_exchange AS price_retail_net,
 CRY.currency_iso_cd,
 MAX(SINW.dat_dayend) AS dat_dayend
FROM ldl_p_lew_core_ac.v_wawi_stc_item_nfb_wh_1 AS SINW
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON SINW.client_id = WH.client_id AND SINW.wh_loc_sid = WH.loc_sid_wh AND
   WH.dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON SINW.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
GROUP BY SINW.client_id,
 wh_id,
 item_id,
 SINW.dat_formdate,
 SINW.pos_nr,
 SINW.pos_nr_link,
 SINW.nfb_type_cd,
 SINW.qty_case_nfb,
 price_retail,
 price_retail_net,
 CRY.currency_iso_cd;
