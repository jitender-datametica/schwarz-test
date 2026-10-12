
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_INV_WH_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
      /*    
      #DescStart#       
      #$Revision: 6244 $, $LastChangedBy: hwieber $   
      #SubjectAreas#: Inventur_1      
      #DescEnd#   
      */    
      SELECT      
      inv1.client_id,   
      inv1.wh_id, 
      inv1.inv_id,      
      inv2.dat_formdate+1 inv_start_date, 
      inv1.dat_formdate inv_end_date      
      FROM (      
      SELECT      
      client_id,  
      wh_id,      
      inv_id,     
      dat_formdate,     
      RANK ( ) OVER (PARTITION BY client_id, wh_id ORDER BY dat_formdate) AS sort   
      FROM p_lew_mart_msi.v_inv_item_wh_1   
      WHERE inv_type = 'F'    
      GROUP BY    
      client_id   
      , wh_id     
      , inv_id    
      , dat_formdate    
      ) inv1      
      LEFT OUTER JOIN ( 
      SELECT      
      client_id,  
      wh_id,      
      inv_id,     
      dat_formdate,     
      RANK ( ) OVER (PARTITION BY client_id, wh_id ORDER BY dat_formdate) AS sort   
      FROM p_lew_mart_msi.v_inv_item_wh_1   
      WHERE  inv_type = 'F'   
      GROUP BY    
      client_id   
      , wh_id     
      , inv_id    
      , dat_formdate    
      ) inv2      
      ON  inv1.client_id = inv2.client_id 
      AND inv1.wh_id  =  inv2.wh_id 
      AND inv1.sort = inv2.sort+1   
;
