/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_ITM_ITEM_WH_DAY_STATUS_HIST
#----------------------------------------------------------------------------
# History:
#  1.0  17.07.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_ITEM_WH_DAY_STATUS_HIST
(    
 client_id  
,wh_id
,loc_sid_wh
,item_sid
,status_hist_id 
,item_status_reason 
,dwh_cal_dt
)    
AS 
SELECT 
 itm.client_id  
,wh.src_wh_id                 AS wh_id
,sts.wh_loc_sid               AS loc_sid_wh
,itm.item_sid 
,sts.item_status              AS status_hist_id  
,sts.item_status_reason 
,cal.cal_dt                    AS dwh_cal_dt
FROM  P_LEW_CORE_AC.v_item                AS itm
LEFT JOIN p_lew_core_ac.v_wawi_itm_item_wh AS sts  
       ON  itm.client_id = sts.client_id   
       AND itm.item_sid = sts.item_sid 
INNER JOIN   P_LEW_CORE_AC.v_cal_calendarday  cal
      ON cal.cal_dt BETWEEN sts.dat_rec_start AND sts.dat_rec_end /* status id ASWAS */
INNER JOIN p_lew_bil_ac.v_warehouse AS wh   /* Warehouse - ASIS */
       ON  sts.client_id = wh.client_id    
       AND sts.wh_loc_sid = wh.loc_sid_wh
       AND wh.dwh_actual_fg = 1    
       AND wh.deleted_fg = 0   
       AND wh.bges_active_fg = 1
     
;

