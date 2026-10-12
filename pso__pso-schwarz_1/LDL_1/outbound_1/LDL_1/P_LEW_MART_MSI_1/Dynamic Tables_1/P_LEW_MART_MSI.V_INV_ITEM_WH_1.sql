
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_inv_item_wh_1
AS
SELECT STW.client_id,
 WH.src_wh_id AS wh_id,
 STW.item_sid AS item_id,
 STW.dat_dayend,
 STW.dat_formdate,
 STW.inv_id,
 STW.inv_type,
 STW.inv_desc,
 STW.busyear AS byr,
 STW.inv_eval_fg,
 STW.store_place,
 STW.aisle_desc,
 STW.slot_nr,
 STW.diff_qty_inv_wh,
  STW.price_retail_inv_wh / CRY.rate_currency_exchange AS price_retail_inv_wh,
  STW.price_retail_net_inv_wh / CRY.rate_currency_exchange AS price_retail_net_inv_wh,
 STW.qty_case_inv_wh,
 STW.qty_piece_inv_wh,
 STW.qty_expected_inv_wh,
 STW.qty_total_inv_wh,
 STW.qty_ramp_inv_wh,
 STW.case_size_dec,
 OSK.st_loc_sid AS store_id,
 CRY.currency_iso_cd
FROM ldl_p_lew_core_ac.v_wawi_inv_item_wh_1 AS STW
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON STW.client_id = WH.client_id AND STW.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey_1 AS OSK ON STW.client_id = OSK.client_id AND WH.src_wh_id
    /* MJD: changed from = stw.wh_loc_sid */ = OSK.orig_store_nr AND CURRENT_DATE BETWEEN OSK.dat_rec_start AND OSK.dat_rec_end
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON STW.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end AND STW.inv_type = 'F';


