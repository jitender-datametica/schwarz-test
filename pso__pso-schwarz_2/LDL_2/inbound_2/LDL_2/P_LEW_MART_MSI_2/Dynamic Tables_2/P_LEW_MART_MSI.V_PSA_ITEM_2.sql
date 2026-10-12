
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PSA_ITEM_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart# 
   #SubjectAreas#: Aktionsverkauf   
   #DescEnd#   
   */ 
   
   SELECT   
   a.ENV_CD      AS ENV_CD,   
   a.REPORT_ID   AS PSA_REPORT_ID,  
   c.CLIENT_ID   AS CLIENT_ID,   
   a.NAT_ITEM_NR AS ORIG_ITEM_NR 
    FROM p_lew_process_ac.v_psa_report_items_2 AS a  
   JOIN p_lew_core_ac.v_wawi_ref_country_2 AS b   
   ON a.COUNTRY_ISO_CD = b.COUNTRY_ISO_CD 
   JOIN p_lew_core_ac.v_wawi_ref_client_country_2 AS c  
   ON b.COUNTRY_ID = c.COUNTRY_ID   
;
