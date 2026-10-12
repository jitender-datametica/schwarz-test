CREATE OR REPLACE view P_LEW_BIL.V_STORE_CONTACT_2 as
   /*	
   #DescStart#	
   #$Revision: 6283 $, $LastChangedBy: hwieber $	
   #SubjectAreas#: Organisationsstruktur	
   #DescEnd#	
   */	
   SELECT	
       lctn.client_id,	
   lctn.loc_sid_store,	
   lctn.src_orig_store_nr,	
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
   lctn.dummy_store_fg,	
   lctn.pseudo_store_fg,	
   lctn.dwh_actual_fg,	
   lctn.active_fg,	
   lctn.active_future_fg	
  FROM p_lew_bil.v_store_2  lctn	
   INNER JOIN p_lew_core_ac.v_address_2 addr	
   ON lctn.addr_sid = addr.addr_sid	
   AND lctn.client_id = addr.client_id;