CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STAT_ORDER_MTH_WORK
(
 client_id  
,cy_month                  
,currency_iso_cd             
,curr_tot_id   
,order_cnt_stationary       
,order_lin_cnt_stationary        
,turnover_net_val_stationary     
,plan_turnover_net_val_stationary                      
)
AS 
SELECT 
 client_id  
,cy_month                  
,currency_iso_cd             
,curr_tot_id   
,order_cnt_stationary       
,order_lin_cnt_stationary        
,turnover_net_val_stationary     
,plan_turnover_net_val_stationary        
FROM  p_lew_mart_lead.v_agg_stat_order_mth_work;