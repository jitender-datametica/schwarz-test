
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ORG_WH_SALES_1 

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
     w.client_id, 
   b.src_wh_id AS wh_id,  
   w.dat_opening, 
   w.costcenter_cd, 
   w.company, 
   w.order_buying_list_cd,  
   w.vat_region_nr, 
   w.region_cd, 
   w.stock_plain, 
   w.sponsion,  
   w.global_location_nr,  
   d.wh_desc, 
   w.distribute_wh_fg,  
   w.int_fg,  
   w.hq_fg, 
   w.prop_wh_fg,  
   w.sales_wh_fg, 
   w.supp_wh_fg,  
   w.wawi_data_fg,  
   w.ovis_data_fg,  
   w.dat_rec_end, 
   w.dat_rec_start  
  FROM p_lew_core_ac.v_wawi_org_wh_store_1 s  
   INNER JOIN p_lew_core_ac.v_wawi_org_wh_1 w 
   ON  s.client_id         = w.client_id  
   AND s.wh_loc_sid   = w.wh_loc_sid  
   INNER JOIN p_lew_core_ac.v_wawi_org_wh_desc_1 d  
   ON  d.client_id        = w.client_id 
   AND d.wh_loc_sid  = w.wh_loc_sid 
   INNER JOIN p_lew_core_ac.v_location_1 b  
   ON   w.client_id = b.client_id 
   AND w.wh_loc_sid = b.loc_sid 
   AND b.wh_store_mark = 'B'  -- Filialen 
  
   WHERE s.wh_type_id = 1 
   AND CURRENT_DATE BETWEEN w.dat_rec_start  AND w.dat_rec_end  
  
   GROUP BY 
     w.client_id  
   , b.src_wh_id  
   , w.dat_opening  
   , w.costcenter_cd  
   , w.company  
   , w.order_buying_list_cd 
   , w.vat_region_nr  
   , w.region_cd  
   , w.stock_plain  
   , w.sponsion 
   , w.global_location_nr 
   , d.wh_desc  
   , w.distribute_wh_fg 
   , w.int_fg 
   , w.hq_fg  
   , w.prop_wh_fg 
   , w.sales_wh_fg  
   , w.supp_wh_fg 
   , w.wawi_data_fg 
   , w.ovis_data_fg 
   , w.dat_rec_end  
   , w.dat_rec_start;
