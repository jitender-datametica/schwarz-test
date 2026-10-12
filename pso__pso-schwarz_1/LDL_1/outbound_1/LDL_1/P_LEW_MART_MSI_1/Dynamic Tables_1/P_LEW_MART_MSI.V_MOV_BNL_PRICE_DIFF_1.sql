CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_mov_bnl_price_diff_1 AS
SELECT MOV.client_id,
 WH.src_wh_id AS wh_id,
 MOV.loc_sid_store AS store_id,
 MOV.sub_item_grp_sid AS subitemgroup_id,
 MOV.receipt_type_id AS formtype,
 MOV.dwh_cal_dt AS dat_formdate,
 MOV.receipt_type_descr AS form_desc,
 MOV.dayend_dt AS dat_dayend,
 MOV.account_id,
  MOV.price_change_debit_val / CRY.rate_currency_exchange AS val_debit_bnl,
  MOV.price_change_debit_net_val / CRY.rate_currency_exchange AS val_debit_net_bnl,
  MOV.price_changel_credit_val / CRY.rate_currency_exchange AS val_credit_bnl,
  MOV.price_change_credit_net_val / CRY.rate_currency_exchange AS val_credit_net_bnl,
 CRY.currency_iso_cd
FROM ldl_p_lew_core_ac.v_price_change_subitemgroup_1 AS MOV
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON MOV.client_id = WH.client_id AND MOV.loc_sid_wh = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON MOV.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;