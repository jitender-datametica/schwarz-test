
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_itm_item_deposit_2
 AS
SELECT ITM.client_id,
 ITM.item_sid AS item_id,
  ITM.val_deposit / CRY.rate_currency_exchange AS val_deposit,
 CRY.currency_iso_cd
FROM ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON ITM.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;

