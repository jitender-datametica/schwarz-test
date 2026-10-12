
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_KPGES_AVAILABILITY_WEEK_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*    
   #DescStart#    
   #$Revision: 6244 $, $LastChangedBy: hwieber $   
   #SubjectAreas#: KPGES Views   
   #DescEnd#   
   */ 
   SELECT   
   clnt.client_id, 
   cal.cy_week,   
   ind.indicator_id, 
   CASE WHEN SUM(iweek.val_indicator) IS NULL THEN 0 ELSE 1 END AS availability_fg  
   FROM p_lew_core_ac.v_wawi_cal_week_1 cal 
   CROSS JOIN p_lew_core_ac.v_wawi_ref_client_country_1 clnt   
   CROSS JOIN p_lew_core_ac.v_wawi_ref_indicator_1 ind  
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_indicator_week_1 iweek   
   ON cal.cy_week = iweek.cy * 100 + iweek.cal_week   
   AND ind.indicator_id = iweek.indicator_id 
   AND iweek.indicator_type_id = 1  
   
   WHERE cal.cy_week_sequence <= 0  
   AND cal.cy_week_sequence BETWEEN -60 AND 0   
   AND ind.indicator_id IN (120, 125, 126, 130, 131, 133, 135, 155, 156, 163, 164, 165, 168, 169, 170,   
   172, 175, 177, 179, 180, 181, 191, 194, 195, 198, 201, 204, 205, 206, 207, 208, 209, 210, 211, 212,   
   216, 217, 218, 219, 220, 221, 222, 223, 224, 227, 228, 229, 236, 238, 239, 245, 255, 256, 257 ,258,   
   259, 260, 261, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280,   
   281, 282, 283) 
   GROUP BY 1,2,3 
;
