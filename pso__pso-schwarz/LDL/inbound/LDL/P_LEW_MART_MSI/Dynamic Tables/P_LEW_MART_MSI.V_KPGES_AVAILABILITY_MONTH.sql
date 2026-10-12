
 /* 
 #DescStart# 
 #$Revision: 16641 $, $LastChangedBy: rcione $ 
 #SubjectAreas#: KPGES Views 
 # 2024-04-12 Stephane Djiomou Tonga Master Version was remigrated from Dev to Prod
 #DescEnd# 
 */ 
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_KPGES_AVAILABILITY_MONTH 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS 
 SELECT 
   CLIENT.client_id 
 , cal.cy_month 
 , ind.indicator_id 
 , CASE WHEN SUM(imonth.val_indicator) IS NULL THEN 0 ELSE 1 END AS availability_fg 
  
 FROM p_lew_core_ac.v_cal_month AS cal 
  
 CROSS JOIN p_lew_core_ac.v_wawi_ref_client_country AS CLIENT
 CROSS JOIN p_lew_core_ac.v_wawi_ref_indicator AS ind 
 LEFT OUTER JOIN p_lew_bil_ac.v_kpi_month AS imonth 
 ON  cal.cy_month = imonth.cy * 100 + imonth.month_id 
 AND ind.indicator_id = imonth.indicator_id 
 AND imonth.indicator_type_id = 1 
  
 WHERE cal.cy_month_seq BETWEEN -26 AND 0 
 AND ind.indicator_id IN (120, 125, 126, 130, 131, 133, 135, 155, 156, 163, 164, 165, 168, 169
 ,170, 172, 175, 177, 179, 180, 181, 191, 194, 195, 198, 201, 204, 205, 206, 207, 208, 209, 210
 ,211, 212, 216, 217, 218, 219, 220, 221, 222, 223, 224, 227, 228, 229, 232, 233, 234, 235, 236
 ,238, 239, 245, 255, 256, 257, 258, 259, 260, 261, 264, 265, 266, 267, 268, 269, 270, 271, 272 
 ,273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283) 
 GROUP BY 1,2,3 
 ;
