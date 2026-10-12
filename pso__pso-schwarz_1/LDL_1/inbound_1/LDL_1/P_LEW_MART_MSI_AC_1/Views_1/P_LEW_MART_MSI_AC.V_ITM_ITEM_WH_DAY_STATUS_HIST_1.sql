/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_ITM_ITEM_WH_DAY_STATUS_HIST_1
#----------------------------------------------------------------------------
# History:
#  1.0  17.07.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_ITEM_WH_DAY_STATUS_HIST_1
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
 client_id  
,wh_id
,loc_sid_wh
,item_sid
,status_hist_id 
,item_status_reason 
,dwh_cal_dt
FROM P_LEW_MART_MSI.V_ITM_ITEM_WH_DAY_STATUS_HIST_1
     
;

