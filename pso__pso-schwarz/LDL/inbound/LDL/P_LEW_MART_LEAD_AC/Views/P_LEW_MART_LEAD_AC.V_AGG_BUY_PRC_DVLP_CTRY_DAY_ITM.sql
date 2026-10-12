/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Individual load SQL for loading of aggregate t_agg_buy_prc_dvlp_wh_day_itm
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2023-09-05   Aleksander Bialek    Initial version, ctry-day-itm level aggregation view for price development metrics.
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_BUY_PRC_DVLP_CTRY_DAY_ITM
( 
 client_id                    
,item_sid            
,sup_sid   
,dat_formdate           
,buying_volume_val
,receive_piece_qty  
,retail_net_val         
,buying_volume_val_py  
,receive_piece_qty_py
,retail_net_val_py      
,buying_volume_val_swpy
,receive_piece_qty_swpy
,retail_net_val_swpy 
,currency_iso_cd   
)
AS 
SELECT  
 agg.client_id              
,item_sid        
,sup_sid       
,dat_formdate           
,buying_volume_val
,receive_piece_qty
,retail_net_val
,buying_volume_val_py
,receive_piece_qty_py
,retail_net_val_py    
,buying_volume_val_swpy
,receive_piece_qty_swpy
,retail_net_val_swpy  
,Cry.currency_iso_cd
FROM P_LEW_MART_LEAD.T_AGG_BUY_PRC_DVLP_CTRY_DAY_ITM agg
INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS Cry
ON  Agg.client_id = Cry.client_id
AND CURRENT_DATE BETWEEN Cry.dat_rec_start AND Cry.dat_rec_end;