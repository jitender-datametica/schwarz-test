
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_SYS_MD_STORELIST_1  
/*
#DescStart# 
#$Revision: 6244 $, $LastChangedBy: hwieber $ 
#SubjectAreas#: Systemtabellen  
#DescEnd# 
*/  
( 
  client_id 
 ,wh_id 
 ,store_id  
 ,dat_open  
) 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS  
   SELECT 
     sl.client_id,  
   wh.src_wh_id                    AS wh_id,  
   sl.loc_sid_store AS store_id,  
   sl.dat_open  
  
    FROM p_lew_bil_ac.v_sys_md_storelist_1 sl 
   INNER JOIN p_lew_bil_ac.v_warehouse_1 wh 
   ON sl.loc_sid_wh = wh.loc_sid_wh 
   AND sl.client_id = wh.client_id  
   AND wh.dwh_actual_fg = 1;
