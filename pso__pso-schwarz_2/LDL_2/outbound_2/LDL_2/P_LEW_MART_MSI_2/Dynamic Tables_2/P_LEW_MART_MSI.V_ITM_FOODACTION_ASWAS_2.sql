CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_itm_foodaction_aswas_2
AS
SELECT ITM.client_id,
 CAL.cal_dt AS dat_valid,
 ITM.item_actiongroup_id,
 ITMP.item_sid_map AS item_id,
 ITM.item_sub_actiongroup_id,
 ITM.subitemgroup_id
FROM ldl_p_lew_core_ac.v_wawi_itm_item_2 AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON CAL.cal_dt BETWEEN ITM.dat_rec_start AND ITM.dat_rec_end AND
   CAL.cal_dt <= CURRENT_DATE
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON ITM.client_id = ITMP.client_id AND ITM.item_sid = ITMP.item_sid
WHERE ITM.item_actiongroup_id = 1
 AND ITM.subitemgroup_id < 100;


