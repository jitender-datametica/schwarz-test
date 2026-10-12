
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_itm_orig_item_case_size
 AS
SELECT W.client_id,
 A.src_wh_id AS wh_id,
 I.orig_item_nr,
 I.dat_valid_from,
 I.case_size
FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh AS W
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act AS I ON W.item_sid = I.item_sid AND W.client_id = I.client_id
 INNER JOIN ldl_p_lew_core_ac.v_location AS A ON W.client_id = A.client_id AND W.wh_loc_sid = A.loc_sid
WHERE W.item_status IN (8, 9)
 AND EXISTS (SELECT 1
  FROM ldl_p_lew_core_ac.v_wawi_itm_item_skey AS K
  WHERE item_sid = W.item_sid
   AND client_id = W.client_id
   AND dat_rec_end = DATE '9999-12-31')
 AND CURRENT_DATE BETWEEN W.dat_rec_start AND W.dat_rec_end;

