CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ORG_STORE_CONTACT_1 as
   /*	
   #DescStart#	
   #$Revision: 7451 $, $LastChangedBy: hwieber $	
   #SubjectAreas#: Organisationsstruktur	
   #DescEnd#	
   */	
   SELECT	
     lcnt.client_id             AS client_id,	
   lcnt.loc_sid_store            AS store_id,	
   COALESCE(lcnt.zip_code, w_st.zipcode)           AS zipcode,	
   COALESCE(lcnt.city, w_st.city)                   AS city,	
   COALESCE(lcnt.street, w_st.street)               AS street,	
   COALESCE(lcnt.postbox, w_st.postbox)                  AS postbox,	
   COALESCE(lcnt.phone_number, w_st.phone)   AS phone,	
   COALESCE(lcnt.fax_number, w_st.fax)       AS fax,	
   COALESCE(w_st.zipcode_postbox, NULL)                  AS zipcode_postbox,	
   COALESCE(w_st.modem, NULL)                            AS modem	
	
  FROM p_lew_bil_ac.v_store_contact_1  lcnt	
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store_contact_1 w_st	
   ON lcnt.client_id = w_st.client_id	
   AND lcnt.loc_sid_store = w_st.st_loc_sid	
   AND CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end	
	
   WHERE	
       lcnt.dwh_actual_fg = 1	
       AND lcnt.pseudo_store_fg = 0	
;