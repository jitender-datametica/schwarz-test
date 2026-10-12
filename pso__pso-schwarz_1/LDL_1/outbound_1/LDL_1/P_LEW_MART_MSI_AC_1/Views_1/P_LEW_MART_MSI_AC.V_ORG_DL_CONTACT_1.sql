/* #DescStart#
#$Revision: 6699 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_org_dl_contact_1 (client_id, wh_id, wh_desc, dat_rec_start, dat_rec_end,
zipcode, city, street, phone, zipcode_postbox, postbox, fax, modem) AS SELECT *
FROM ldl_p_lew_mart_msi.v_org_dl_contact_1;