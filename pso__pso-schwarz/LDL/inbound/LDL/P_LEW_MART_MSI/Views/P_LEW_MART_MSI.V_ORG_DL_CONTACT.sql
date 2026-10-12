CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ORG_DL_CONTACT
AS	
   /*	
   #DescStart#	
   #$Revision: 6806 $, $LastChangedBy: hwieber $	
   #SubjectAreas#: Organisationsstruktur 	
   #DescEnd#	
   */	
   SELECT	
     con.client_id,	
   wh.src_wh_id AS wh_id,	
   des.wh_desc,	
   con.dat_rec_start,	
   con.dat_rec_end,	
   con.zipcode,	
   con.city,	
   con.street,	
   con.phone,	
   con.zipcode_postbox,	
   con.postbox,	
   con.fax,	
   con.modem	
  FROM p_lew_core_ac.v_wawi_org_wh_contact con	
   INNER JOIN p_lew_core_ac.v_wawi_org_wh_desc des	
   ON con.client_id = des.client_id	
   AND con.wh_loc_sid = des.wh_loc_sid	
   INNER JOIN p_lew_core_ac.v_location wh	
   ON con.client_id = wh.client_id	
   AND con.wh_loc_sid = wh.loc_sid	
   INNER JOIN p_lew_mart_msi.v_ref_user_language AS lg	
   ON  lower(current_USER) = lower(lg.db_user)	
   AND des.language_id = lg.language_id	
WHERE CURRENT_DATE BETWEEN con.dat_rec_start AND con.dat_rec_end	
AND wh.src_wh_id = 0	
;