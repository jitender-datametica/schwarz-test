/* #DescStart#	
   #$Revision: 6283 $, $LastChangedBy: hwieber $	
   #SubjectAreas#: Organisationsstruktur	
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_store_contact_2 AS SELECT LCTN.client_id,
 LCTN.loc_sid_store,
 LCTN.src_orig_store_nr,
 ADDR.lang_sid,
 ADDR.country_pol_sid,
 ADDR.lang_cd,
 ADDR.country_pol_cd,
 ADDR.name1,
 ADDR.name2,
 ADDR.name3,
 ADDR.sort1,
 ADDR.street,
 ADDR.house_number1,
 ADDR.house_number2,
 ADDR.city,
 ADDR.postbox,
 ADDR.zip_code,
 ADDR.phone_number,
 ADDR.fax_number,
 LCTN.dwh_valid_from,
 LCTN.dwh_valid_to,
 LCTN.dummy_store_fg,
 LCTN.pseudo_store_fg,
 LCTN.dwh_actual_fg,
 LCTN.active_fg,
 LCTN.active_future_fg
FROM ldl_p_lew_bil.v_store_2 AS LCTN
 INNER JOIN ldl_p_lew_core_ac.v_address_2 AS ADDR ON LCTN.addr_sid = ADDR.addr_sid AND LCTN.client_id = ADDR.client_id;