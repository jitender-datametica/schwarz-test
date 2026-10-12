CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ORG_ALL_STORE_RELOC as
   /*	
   #DescStart#	
   #$Revision: 6244 $, $LastChangedBy: hwieber $	
   #SubjectAreas#: Organisationsstruktur	
   #DescEnd#	
   */	
	
   SELECT	
     move_to_st_loc_sid    move_to_store_id,	
   st_loc_sid  AS store_id,	
   store_desc AS store_desc,	
   client_id AS client_id,	
   orig_store_nr AS orig_store_nr,	
   move_fg AS move_fg	
  FROM p_lew_core_ac.v_wawi_org_all_store_reloc_act;