CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ORG_WH_CONTACT_2 

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
     wh.client_id
   ,wh.src_wh_id AS wh_id	
   ,wh.dwh_valid_from AS dat_rec_start
   ,wh.dwh_valid_to AS dat_rec_end	
   ,wh.zip_code AS  zipcode	
   ,wh.city AS city
   ,wh.street AS street	
   ,wh.phone_number AS phone	
   ,wh.postbox AS zipcode_postbox
   ,wh.postbox AS postbox	
   ,wh.fax_number AS fax	
   ,wh_con.modem AS modem	
  FROM p_lew_bil_ac.v_warehouse_contact_2  wh	
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_wh_contact_2 wh_con	
   ON     wh.loc_sid_wh = wh_con.wh_loc_sid	
   AND  wh.client_id = wh_con.client_id	
   AND  CURRENT_DATE BETWEEN wh_con.dat_rec_start AND wh_con.dat_rec_end	
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_wh_2 wh_wawi	
   ON     wh.loc_sid_wh = wh_wawi.wh_loc_sid	
   AND  wh.client_id = wh_wawi.client_id	
   AND  CURRENT_DATE BETWEEN wh_wawi.dat_rec_start AND wh_wawi.dat_rec_end	
   LEFT OUTER JOIN p_lew_core_ac.v_client_migration_per_2  mig	
   ON wh.client_id = mig.client_id	
	
   WHERE  wh.dwh_actual_fg = 1	
   AND  wh.src_wh_id  > 0	
   AND ( wh_wawi.wawi_data_fg = 1 OR	
   (	
   CASE WHEN mig.active_fg = 1 AND  wh.global_loc_id_length = 7	
   AND wh.global_loc_type_cd = '9'	
   AND COALESCE (wh.country_pol_cd, wh_wawi.country_cd)  IS NOT NULL  THEN 1 ELSE 0  END  = 1	
   )	
   );