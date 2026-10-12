/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Individual load SQL for loading of aggregate t_agg_sell_prc_dvlp_wh_day_itm
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2022-09-14   Aleksander Bialek    Initial version, wh-day-itm level aggregation view for price development metrics.
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_SELL_PRC_DVLP_WH_DAY_ITM
( 
 client_id              
,wh_id                  
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
 agg.client_id              
,wh_id                  
,item_sid               
,dat_formdate           
,sales_volume_val
,sales_piece_qty
,sales_volume_val_py
,sales_piece_qty_py
,sales_volume_val_swpy
,sales_piece_qty_swpy
,Cry.currency_iso_cd
FROM P_LEW_MART_LEAD.T_AGG_SELL_PRC_DVLP_WH_DAY_ITM agg
INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS Cry
ON  Agg.client_id = Cry.client_id
AND CURRENT_DATE BETWEEN Cry.dat_rec_start AND Cry.dat_rec_end;