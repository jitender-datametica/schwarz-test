CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.V_L_LIFECYCLE_EXCHANGE_RATE_2
AS 
SELECT
 CORE.t_dim_exchange_rate.dwh_valid_from_dt
,CORE.t_dim_exchange_rate.dwh_valid_to_dt  
,CORE.t_dim_exchange_rate.active_from_dt
,CORE.t_dim_exchange_rate.active_to_dt  
,CORE.t_dim_exchange_rate.curr_cd_from  
,CORE.t_dim_exchange_rate.curr_cd_to    
,CORE.t_dim_exchange_rate.exchange_rate 
FROM
CORE.t_dim_exchange_rate_2
;