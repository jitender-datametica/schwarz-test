/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.V_AGG_ROC_WH_DAY_ITEM_1
#----------------------------------------------------------------------------
# History:
#  1.0  05.02.2024    Aparna Rayanki           Initial Version
#  1.1  21.10.2024    Aparna Rayanki           Added prices columns
#                                              https://dev.azure.com/schwarzit/schwarzit.bikid-lidl/_workitems/edit/682357/
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_AGG_ROC_WH_DAY_ITEM_1
(
 client_id                      
,loc_sid_wh                     
,item_sid                       
,dwh_cal_dt                     
,listing_type_id_hist           
,stock_fg                       
,qty_sales_avg_35_days_fg       
,item_group_fg                  
,qty_piece_ejr_asis	            
,qty_weight_ejr_asis            
,qty_return_ejr_asis            
,qty_piece_stc_wh               
,qty_total_adj_sales_avg_35_days
,current_wh_stc_retail_net_price
,last_wh_stc_retail_net_price   
,dwh_created 
 )
AS
SELECT
 client_id                      
,loc_sid_wh                     
,item_sid                       
,dwh_cal_dt                     
,listing_type_id_hist           
,stock_fg                       
,qty_sales_avg_35_days_fg       
,item_group_fg                  
,qty_piece_ejr_asis	            
,qty_weight_ejr_asis            
,qty_return_ejr_asis            
,qty_piece_stc_wh               
,qty_total_adj_sales_avg_35_days
,current_wh_stc_retail_net_price
,last_wh_stc_retail_net_price  
,dwh_created                    
FROM p_lew_bil.t_agg_roc_wh_day_item_1
;