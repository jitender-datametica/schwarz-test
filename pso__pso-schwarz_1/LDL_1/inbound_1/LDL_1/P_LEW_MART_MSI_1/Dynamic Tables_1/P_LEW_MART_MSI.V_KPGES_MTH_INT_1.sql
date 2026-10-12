
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_KPGES_MTH_INT_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*    
   #DescStart#    
   #$Revision: 10901 $, $LastChangedBy: ekun $  
   #SubjectAreas#: KPGES Views   
   #DescEnd#   
   # 12.04.2024    Stephane Djiomou Tonga   Master Version was remigrated from Dev to Prod
   */ 
   SELECT   
   im.indicator_id   
   ,im.cy * 100 + im.month_id AS cy_month
   ,im.val_indicator 
   ,cry.currency_iso_cd
   ,im.dat_dayend 
   
   FROM p_lew_bil_ac.v_kpi_month_1 AS im 
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry   
   ON  im.client_id = cry.client_id 
   AND im.org_type_id = 10 
   AND im.indicator_type_id = 1  
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
;
