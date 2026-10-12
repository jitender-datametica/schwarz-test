
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_INV_WH_SALES 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
    /*  
    #DescStart#     
    #$Revision: 6699 $, $LastChangedBy: hwieber $   
    #SubjectAreas#: Inventur    
    #DescEnd#   
    */  
   SELECT rtl.client_id,    
   rtl.src_wh_id AS wh_id,  
   1 AS inv_id, 
   rtl.dwh_cal_dt AS inv_start_date,    
   rtl.dwh_cal_dt AS inv_end_date,  
   currh.curr_cd_from AS currency_iso_cd,   
   SUM(rtl.retail_val) / currh.exchange_rate AS val_retail, 
   SUM(rtl.retail_net_val) / currh.exchange_rate AS val_retail_net  
   FROM p_lew_bil_ac.v_agg_item_store_day AS rtl    
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS currh 
   ON rtl.client_id = currh.client_id   
   AND CURRENT_DATE BETWEEN currh.active_from_dt AND currh.active_to_dt 
   AND CURRENT_DATE BETWEEN currh.dwh_valid_from AND currh.dwh_valid_to 
   INNER JOIN p_lew_core_ac.v_exchange_rate_type AS currt   
   ON rtl.client_id = currt.client_id   
   AND currh.x_rate_type_sid  = currt.x_rate_type_sid   
   AND currt.src_kurst = '@BEWE'    
WHERE ( 
rtl.retail_val IS NOT NULL  
OR rtl.retail_net_val IS NOT NULL   
)   
GROUP BY rtl.client_id  
, rtl.src_wh_id 
, rtl.dwh_cal_dt    
, currh.curr_cd_from    
, currh.exchange_rate   
;
