/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.V_AGG_RECEIVE_WH_ITEM_DAY
#----------------------------------------------------------------------------
# History:
#  1.0  22.10.2024    Aparna Rayanki           Initial Version
#                                              https://dev.azure.com/schwarzit/schwarzit.bikid-lidl/_workitems/edit/688269/
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_AGG_RECEIVE_WH_ITEM_DAY
(
 client_id             
 ,wh_loc_sid            
 ,src_wh_id             
 ,orig_item_nr          
 ,dwh_cal_dt            
 ,curr_sid              
 ,currency_iso_cd       
 ,current_rcv_qty       
 ,current_rcv_buying_val
 ,current_buying_price  
 ,last_buying_price     
 ,dwh_created           
)
AS
SELECT
 client_id             
,wh_loc_sid            
,src_wh_id             
,orig_item_nr          
,dwh_cal_dt            
,curr_sid              
,currency_iso_cd       
,current_rcv_qty       
,current_rcv_buying_val
,current_buying_price  
,last_buying_price     
,dwh_created           
FROM P_LEW_BIL.T_AGG_RECEIVE_WH_ITEM_DAY
;