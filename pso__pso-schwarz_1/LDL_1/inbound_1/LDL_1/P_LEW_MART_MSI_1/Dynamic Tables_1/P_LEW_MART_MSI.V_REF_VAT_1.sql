
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_VAT_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   -- New VAT table  
   SELECT   
   t1.client_id,  
   t1.vat_id,  
   CAST(t1.pct_vat AS DECIMAL(18,4)) AS pct_vat,   
   t1.vat_desc 
   FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 AS t1_1   
   WHERE CURRENT_DATE BETWEEN t1.dat_rec_start AND t1.dat_rec_end 
   
   UNION 
   
   -- Old VAT table  
   SELECT   
   t2.client_id,  
   t2.vat_id,  
   t2.pct_vat, 
   t2.vat_desc 
   FROM p_lew_core_ac.v_wawi_ref_vat_1 AS t2   
   LEFT OUTER JOIN   
   (  
   SELECT   
   tck1.client_id 
   FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 tck1 
   WHERE tck1.vat_id > 0   
   GROUP BY 
   tck1.client_id 
   ) tck2   
   ON t2.client_id = tck2.client_id 
   WHERE CURRENT_DATE BETWEEN t2.dat_rec_start AND t2.dat_rec_end 
   AND   t2.client_id = t2.language_id 
   -- Display data from ref_vat only, if ref_wawi_vat_values has no real data for that client_id   
   AND   tck2.client_id IS NULL  
;
