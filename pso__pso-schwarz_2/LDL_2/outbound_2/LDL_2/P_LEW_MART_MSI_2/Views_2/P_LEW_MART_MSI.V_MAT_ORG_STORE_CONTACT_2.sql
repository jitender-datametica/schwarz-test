/* #DescStart#	
   #$Revision: 7451 $, $LastChangedBy: hwieber $	
   #SubjectAreas#: Organisationsstruktur	
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_org_store_contact_2 AS SELECT LCNT.client_id,
 LCNT.loc_sid_store AS store_id,
 COALESCE(LCNT.zip_code, W_ST.zipcode) AS zipcode,
 COALESCE(LCNT.city, W_ST.city) AS city,
 COALESCE(LCNT.street, W_ST.street) AS street,
 COALESCE(LCNT.postbox, W_ST.postbox) AS postbox,
 COALESCE(LCNT.phone_number, W_ST.phone) AS phone,
 COALESCE(LCNT.fax_number, W_ST.fax) AS fax,
 W_ST.zipcode_postbox,
 W_ST.modem
FROM ldl_p_lew_bil_ac.v_store_contact_2 AS LCNT
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_contact_2 AS W_ST ON LCNT.client_id = W_ST.client_id AND LCNT.loc_sid_store
    = W_ST.st_loc_sid AND CURRENT_DATE BETWEEN W_ST.dat_rec_start AND W_ST.dat_rec_end
WHERE LCNT.dwh_actual_fg = 1
 AND LCNT.pseudo_store_fg = 0;