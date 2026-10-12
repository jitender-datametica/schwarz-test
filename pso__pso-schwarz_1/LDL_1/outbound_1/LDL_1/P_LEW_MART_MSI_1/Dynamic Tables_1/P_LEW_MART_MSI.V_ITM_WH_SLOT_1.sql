CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_itm_wh_slot_1 AS
SELECT ITM.client_id,
 WH.src_wh_id AS wh_id,
 ITM.item_sid AS item_id,
 ITM.wh_slot_case,
 ITM.wh_slot_pallet,
 ITM.wh_slot_dd,
 ITM.inv_case_fg,
 ITM.inv_euro_fg,
 ITM.inv_dd_fg
FROM ldl_p_lew_core_ac.v_wawi_itm_wh_slot_1 AS ITM
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON ITM.client_id = WH.client_id AND ITM.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
WHERE CURRENT_DATE BETWEEN ITM.dat_rec_start AND ITM.dat_rec_end;