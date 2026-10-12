
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PSA_STORE 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*    
   #DescStart#    
   #$Revision: 8438 $, $LastChangedBy: umeister $  
   #SubjectAreas#: Aktionsverkauf   
   #DescEnd#   
   */ 
   
   SELECT   
   a.ENV_CD    AS ENV_CD,  
   a.REPORT_ID AS PSA_REPORT_ID, 
   c.CLIENT_ID AS CLIENT_ID,  
   a.STORE_NR  AS ORIG_STORE_NR  
    FROM p_lew_process_ac.v_psa_report_stores AS a 
   JOIN p_lew_core_ac.v_wawi_ref_country AS b   
   ON a.COUNTRY_ISO_CD = b.COUNTRY_ISO_CD 
   JOIN p_lew_core_ac.v_wawi_ref_client_country AS c  
   ON b.COUNTRY_ID = c.COUNTRY_ID   
   
   GROUP BY 1,2,3,4  
;
