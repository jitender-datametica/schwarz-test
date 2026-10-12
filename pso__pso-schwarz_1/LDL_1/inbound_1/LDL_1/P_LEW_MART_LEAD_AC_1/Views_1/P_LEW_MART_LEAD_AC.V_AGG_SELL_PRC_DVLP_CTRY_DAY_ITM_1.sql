
/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Individual load SQL for loading of aggregate t_agg_sell_prc_dvlp_wh_day_itm_1
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2023-09-05   Aleksander Bialek    Initial version, ctry-day-itm level aggregation view for price development metrics.
# 1.1  2024-07-29   Aleksander Bialek    Adjusted version, re_1-pointed to the ctry-day-itm level view . Old aggregation table obsolete, will be cleanup later on (ADWI:512479)
# 1.2  2024-08-16   Aleksander Bialek    Addineg the data processing in the successor context (ADWI:655914)
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_SELL_PRC_DVLP_CTRY_DAY_ITM_1
( 
 client_id              
,item_sid               
,dat_formdate           
,sales_volume_val       
,sales_piece_qty   	 
,sales_volume_val_py    
,sales_piece_qty_py     
,sales_volume_val_swpy  
,sales_piece_qty_swpy   
,cbx_pred_sales_volume_val
,cbx_pred_sales_piece_qty
,cbx_pred_sales_volume_val_py
,cbx_pred_sales_piece_qty_py
,cbx_pred_sales_volume_val_swpy
,cbx_pred_sales_piece_qty_swpy
,cbx_pred_pred_sales_volume_val
,cbx_pred_pred_sales_piece_qty
,cbx_pred_pred_sales_volume_val_py
,cbx_pred_pred_sales_piece_qty_py
,cbx_pred_pred_sales_volume_val_swpy
,cbx_pred_pred_sales_piece_qty_swpy
,cbx_pred2_sales_volume_val
,cbx_pred2_sales_piece_qty
,cbx_pred2_sales_volume_val_py
,cbx_pred2_sales_piece_qty_py
,cbx_pred2_sales_volume_val_swpy
,cbx_pred2_sales_piece_qty_swpy
,cbx_succ_sales_volume_val
,cbx_succ_sales_piece_qty
,cbx_succ_sales_volume_val_py
,cbx_succ_sales_piece_qty_py
,cbx_succ_sales_volume_val_swpy
,cbx_succ_sales_piece_qty_swpy
,cbx_succ_succ_sales_volume_val
,cbx_succ_succ_sales_piece_qty
,cbx_succ_succ_sales_volume_val_py
,cbx_succ_succ_sales_piece_qty_py
,cbx_succ_succ_sales_volume_val_swpy
,cbx_succ_succ_sales_piece_qty_swpy
,cbx_succ2_sales_volume_val
,cbx_succ2_sales_piece_qty
,cbx_succ2_sales_volume_val_py
,cbx_succ2_sales_piece_qty_py
,cbx_succ2_sales_volume_val_swpy
,cbx_succ2_sales_piece_qty_swpy
,currency_iso_cd

)
AS 
SELECT  
 agg.client_id              
,item_sid               
,dat_formdate           
,sales_volume_val       
,sales_piece_qty   	 
,sales_volume_val_py    
,sales_piece_qty_py     
,sales_volume_val_swpy  
,sales_piece_qty_swpy   
,cbx_pred_sales_volume_val
,cbx_pred_sales_piece_qty
,cbx_pred_sales_volume_val_py
,cbx_pred_sales_piece_qty_py
,cbx_pred_sales_volume_val_swpy
,cbx_pred_sales_piece_qty_swpy
,cbx_pred_pred_sales_volume_val
,cbx_pred_pred_sales_piece_qty
,cbx_pred_pred_sales_volume_val_py
,cbx_pred_pred_sales_piece_qty_py
,cbx_pred_pred_sales_volume_val_swpy
,cbx_pred_pred_sales_piece_qty_swpy
,cbx_pred2_sales_volume_val
,cbx_pred2_sales_piece_qty
,cbx_pred2_sales_volume_val_py
,cbx_pred2_sales_piece_qty_py
,cbx_pred2_sales_volume_val_swpy
,cbx_pred2_sales_piece_qty_swpy
,cbx_succ_sales_volume_val
,cbx_succ_sales_piece_qty
,cbx_succ_sales_volume_val_py
,cbx_succ_sales_piece_qty_py
,cbx_succ_sales_volume_val_swpy
,cbx_succ_sales_piece_qty_swpy
,cbx_succ_succ_sales_volume_val
,cbx_succ_succ_sales_piece_qty
,cbx_succ_succ_sales_volume_val_py
,cbx_succ_succ_sales_piece_qty_py
,cbx_succ_succ_sales_volume_val_swpy
,cbx_succ_succ_sales_piece_qty_swpy
,cbx_succ2_sales_volume_val
,cbx_succ2_sales_piece_qty
,cbx_succ2_sales_volume_val_py
,cbx_succ2_sales_piece_qty_py
,cbx_succ2_sales_volume_val_swpy
,cbx_succ2_sales_piece_qty_swpy 
,Cry.currency_iso_cd
FROM P_LEW_MART_LEAD.V_AGG_SELL_PRC_DVLP_CTRY_DAY_ITM_1 agg
INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS Cry
ON  Agg.client_id = Cry.client_id
AND CURRENT_DATE BETWEEN Cry.dat_rec_start AND Cry.dat_rec_end;