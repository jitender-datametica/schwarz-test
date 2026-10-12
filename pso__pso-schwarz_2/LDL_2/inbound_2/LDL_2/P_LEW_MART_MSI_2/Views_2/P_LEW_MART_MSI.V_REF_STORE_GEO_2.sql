CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_STORE_GEO_2 as
   /*	
   #DescStart#	
   #$Revision: 6244 $, $LastChangedBy: hwieber $	
   #SubjectAreas#: Organisationsstruktur	
   #DescEnd#	
   */	
   SELECT	
    client_id,	
   st_loc_sid AS store_id,	
   latitude,	
   longitude	
   FROM p_lew_core_ac.v_wawi_ref_store_geo_2	
   GROUP BY 1,2,3,4;