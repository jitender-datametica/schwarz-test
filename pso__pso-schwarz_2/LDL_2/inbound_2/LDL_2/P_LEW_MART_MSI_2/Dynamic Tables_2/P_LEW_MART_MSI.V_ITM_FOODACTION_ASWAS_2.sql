CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_FOODACTION_ASWAS_2 
TARGET_LAG = '1 hour, 30 minutes'  -- dummy_2 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI
AS
   SELECT	
      itm.client_id	
   ,cal.cal_dt AS dat_valid
   ,itm.item_actiongroup_id
   ,itmp.item_sid_map AS item_id	
   ,itm.item_sub_actiongroup_id	
   ,itm.subitemgroup_id	
   FROM p_lew_core_ac.v_wawi_itm_item_2 itm	
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 cal	
   ON cal.cal_dt BETWEEN itm.dat_rec_start AND itm.dat_rec_end	
   AND cal.cal_dt <= CURRENT_DATE	
   INNER JOIN p_lew_core_ac.v_item_map_key_2 itmp	
   ON itmp.client_id = itm.client_id	
   AND itmp.item_sid = itm.item_sid	
	
 WHERE itm.item_actiongroup_id = 1	
   AND itm.subitemgroup_id < 100	
;