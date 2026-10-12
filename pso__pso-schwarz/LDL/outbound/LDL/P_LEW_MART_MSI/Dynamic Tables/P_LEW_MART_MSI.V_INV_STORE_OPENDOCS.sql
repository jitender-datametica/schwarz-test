
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_inv_store_opendocs
AS
SELECT ISOD.client_id,
 ISOD.st_loc_sid AS store_id,
 WH.src_wh_id AS wh_id,
 ISOD.inv_id,
 ISOD.sfotype_id,
 ISOD.dat_dayend,
 ISOD.dat_formdate,
 ISOD.orig_receipt_nr_opendocs,
  ISOD.val_debit_opendocs / CRY.rate_currency_exchange AS val_debit_opendocs,
  ISOD.val_debit_opendocs_net / CRY.rate_currency_exchange AS val_debit_opendocs_net,
  ISOD.val_credit_opendocs / CRY.rate_currency_exchange AS val_credit_opendocs,
  ISOD.val_credit_opendocs_net / CRY.rate_currency_exchange AS val_credit_opendocs_net,
 CRY.currency_iso_cd,
 CRY.rate_currency_exchange
FROM ldl_p_lew_core_ac.v_wawi_inv_store_opendocs AS ISOD
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON ISOD.client_id = WH.client_id AND ISOD.wh_loc_sid = WH.loc_sid_wh AND
   WH.dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON ISOD.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_wawi_inv_store AS H ON ISOD.client_id = H.client_id AND ISOD.st_loc_sid = H.st_loc_sid
      AND ISOD.wh_loc_sid = H.wh_loc_sid AND ISOD.inv_id = H.inv_id AND ISOD.dat_dayend = H.dat_dayend AND H.inv_fg = 71
     AND H.status_inv_sic = 64;
