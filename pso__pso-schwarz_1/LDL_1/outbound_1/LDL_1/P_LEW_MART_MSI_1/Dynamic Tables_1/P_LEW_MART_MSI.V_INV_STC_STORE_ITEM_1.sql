CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_inv_stc_store_item_1
 AS
SELECT STC.client_id,
 STC.item_sid AS item_id,
 STC.dwh_cal_dt AS dat_formdate,
 STC.loc_sid AS store_id,
 STC.calc_stock_qty AS qty_inv_stc_calc,
 STC.inv_stock_qty AS qty_inv_stc_cnt,
 STC.inv_calc_stock_diff AS diff_inv_stc_calc_cnt,
 STC.inv_status_id AS status_inv_stc,
 CAST(STC.retail_price / CRY.rate_currency_exchange AS BIGNUMERIC) AS price_retail,
 CAST(STC.retail_net_price / CRY.rate_currency_exchange AS BIGNUMERIC) AS price_retail_net,
 CRY.currency_iso_cd
FROM ldl_p_lew_core_ac.v_item_store_inventory_stock_1 AS STC
 INNER JOIN ldl_p_lew_core_ac.v_wawi_inv_store_1 AS INV ON STC.client_id = INV.client_id AND STC.loc_sid = INV.st_loc_sid
    AND STC.dwh_cal_dt = INV.dat_formdate AND INV.inv_fg = 71 AND INV.status_inv_sic = 64
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON STC.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;

