
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_itm_item_store
AS
SELECT COALESCE(ITM.case_size_dec, ITM.case_size) AS case_size,
 ORG.client_id,
 ITM.dat_valid_from,
 ITMW.item_sid AS item_id,
 ITM.orig_item_nr,
 ITMW.item_status AS status_id,
 ORG.st_loc_sid AS store_id,
 WH.src_wh_id AS wh_id
FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh AS ITMW
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act AS ITM ON ITMW.client_id = ITM.client_id AND ITMW.item_sid = ITM.item_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey_act AS ORG ON ITMW.client_id = ORG.client_id AND ITMW.wh_loc_sid =
   ORG.wh_loc_sid
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON ORG.client_id = WH.client_id AND ORG.wh_loc_sid = WH.loc_sid_wh
WHERE CURRENT_DATE BETWEEN ITMW.dat_rec_start AND ITMW.dat_rec_end
GROUP BY case_size,
 ORG.client_id,
 ITM.dat_valid_from,
 item_id,
 ITM.orig_item_nr,
 status_id,
 store_id,
 wh_id;

