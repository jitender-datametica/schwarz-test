CREATE OR REPLACE view P_LEW_BIL.V_WAREHOUSE_CONTACT as
	
   /*	
   #DescStart#	
   #$Revision: 6283 $, $LastChangedBy: hwieber $	
   #SubjectAreas#  COEX  Organisationsstruktur	
   #DescEnd#	
   */	
	
   SELECT	
    lctn.client_id,	
   lctn.loc_sid_wh,	
   lctn.src_wh_id,	
   lctn.addr_sid,	
   addr.lang_sid,	
   addr.country_pol_sid,	
   addr.lang_cd,	
   addr.country_pol_cd,	
   addr.name1,	
   addr.name2,	
   addr.name3,	
   addr.sort1,	
   addr.street,	
   addr.house_number1,	
   addr.house_number2,	
   addr.city,	
   addr.postbox,	
   addr.zip_code,	
   addr.phone_number,	
   addr.fax_number,	
   lctn.dwh_valid_from,	
   lctn.dwh_valid_to,	
   lctn.dwh_actual_fg,	
   lctn.active_fg,	
   lctn.active_future_fg,	
   lctn.global_loc_id_length,	
   lctn.global_loc_type_cd,	
   addr.street||' '|| addr.house_number1 AS street_number	
  FROM p_lew_bil.v_warehouse lctn	
   INNER JOIN p_lew_core_ac.v_address addr	
   ON lctn.addr_sid = addr.addr_sid	
   AND lctn.client_id = addr.client_id	;