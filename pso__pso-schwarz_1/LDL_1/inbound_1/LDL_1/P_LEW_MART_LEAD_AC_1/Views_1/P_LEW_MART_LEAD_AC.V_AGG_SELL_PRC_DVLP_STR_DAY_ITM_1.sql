/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Individual load SQL for loading of aggregate t_agg_prc_dvlp_wh_day_itm
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2022-09-14   Aleksander Bialek    Initial version, view delivering IST-VJ  values for components of price development metrics.
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_SELL_PRC_DVLP_STR_DAY_ITM_1
( 
 client_id              
,loc_sid_store_move_to                  
,item_sid               
,dat_formdate                          
,sales_volume_val       
,sales_piece_qty   	 
,sales_volume_val_py    
,sales_piece_qty_py     
,sales_volume_val_swpy  
,sales_piece_qty_swpy   
,currency_iso_cd
)
AS 
SELECT  
 client_id              
,move_to_store_id AS loc_sid_store_move_to                  
,item_sid               
,dat_formdate           
,sales_volume_val
,sales_piece_qty
,sales_volume_val_py
,sales_piece_qty_py
,sales_volume_val_swpy
,sales_piece_qty_swpy 
,currency_iso_cd
FROM P_LEW_MART_LEAD.V_AGG_SELL_PRC_DVLP_STR_DAY_ITM_1 
;