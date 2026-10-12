
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_LEAD_STORE_TECH_LIST_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart#  
   #$Revision: 6244 $, $LastChangedBy: hwieber $  
   #SubjectAreas#: Organisationsstruktur  
   #DescEnd#  
   */ 
   SELECT 
     osp.client_id, 
   osp.store_id,  
   cry.curr_tot_id, 
   cry.currency_iso_cd  
  
  FROM p_lew_mart_msi.v_org_store_pre_2 AS osp  
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS crt  
   ON  osp.client_id = crt.client_id  
   AND CURRENT_DATE BETWEEN crt.dat_rec_start AND crt.dat_rec_end 
   INNER JOIN p_lew_mart_msi.v_ref_currency_2 AS cry  
   ON  crt.currency_iso_cd = cry.currency_iso_cd  
   AND crt.client_id = cry.client_id;
