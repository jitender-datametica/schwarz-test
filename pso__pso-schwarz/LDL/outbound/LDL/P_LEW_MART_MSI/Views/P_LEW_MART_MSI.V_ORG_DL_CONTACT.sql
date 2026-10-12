CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_org_dl_contact AS SELECT CON.client_id,
 WH.src_wh_id AS wh_id,
 DES.wh_desc,
 CON.dat_rec_start,
 CON.dat_rec_end,
 CON.zipcode,
 CON.city,
 CON.street,
 CON.phone,
 CON.zipcode_postbox,
 CON.postbox,
 CON.fax,
 CON.modem
FROM ldl_p_lew_core_ac.v_wawi_org_wh_contact AS CON
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_desc AS DES ON CON.client_id = DES.client_id AND CON.wh_loc_sid = DES.wh_loc_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_location AS WH ON CON.client_id = WH.client_id AND CON.wh_loc_sid = WH.loc_sid
 INNER JOIN ldl_p_lew_mart_msi.v_ref_user_language AS LG ON LOWER(SESSION_USER()) = LOWER(LG.db_user) AND DES.language_id
    = LG.language_id
WHERE CURRENT_DATE BETWEEN CON.dat_rec_start AND CON.dat_rec_end
 AND WH.src_wh_id = 0;