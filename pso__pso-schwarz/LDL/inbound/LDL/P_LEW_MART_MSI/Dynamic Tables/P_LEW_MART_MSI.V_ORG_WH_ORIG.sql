CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ORG_WH_ORIG 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
     SELECT	
       wh.client_id	
     ,src_wh_id AS wh_id	
     ,COALESCE (wh.country_pol_cd, wh_wawi.country_cd)  AS country_cd	
     ,wh.opening_dt AS dat_opening	
     ,wh_wawi.costcenter_cd
     ,wh_wawi.company AS company
     ,wh_wawi.order_buying_list_cd
     ,wh_wawi.vat_region_nr
     ,wh_wawi.region_cd
     ,wh_wawi.stock_plain
     ,wh_wawi.sponsion
     ,wh_wawi.global_location_nr	
     ,wh.loc_name wh_desc
     ,wh_wawi.distribute_wh_fg
     ,wh_wawi.int_fg
     ,wh_wawi.hq_fg
     ,wh_wawi.prop_wh_fg	
     ,wh_wawi.sales_wh_fg	
     ,wh_wawi.supp_wh_fg	
     ,wh_wawi.wawi_data_fg	
     ,wh_wawi.ovis_data_fg	
	
 FROM p_lew_bil_ac.v_warehouse  wh	
     LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_wh wh_wawi	
     ON     wh.loc_sid_wh = wh_wawi.wh_loc_sid	
     AND  wh.client_id = wh_wawi.client_id	
     AND  Current_Date BETWEEN wh_wawi.dat_rec_start AND wh_wawi.dat_rec_end	
     LEFT OUTER JOIN p_lew_core_ac.v_client_migration_per  mig	
     ON wh.client_id = mig.client_id	
	
     WHERE  wh.dwh_actual_fg = 1	
     AND  src_wh_id  > 0	
     AND ( wh_wawi.wawi_data_fg = 1 OR	
     (	
     CASE WHEN mig.active_fg = 1 AND  wh.global_loc_id_length = 7	
     AND wh.global_loc_type_cd = '9'	
     AND country_cd IS NOT NULL  THEN 1 ELSE 0  END  = 1	
     )	
     )	
;