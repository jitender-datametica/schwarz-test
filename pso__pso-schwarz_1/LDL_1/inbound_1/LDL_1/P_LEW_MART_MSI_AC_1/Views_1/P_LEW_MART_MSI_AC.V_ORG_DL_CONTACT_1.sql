CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ORG_DL_CONTACT_1
/*
#DescStart#
#$Revision: 6699 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
client_id
, wh_id
, wh_desc
, dat_rec_start
, dat_rec_end
, zipcode
, city
, street
, phone
, zipcode_postbox
, postbox
, fax
, modem
 )
AS
SELECT
client_id,
wh_id,
wh_desc,
dat_rec_start,
dat_rec_end,
zipcode,
city,
street,
phone,
zipcode_postbox,
postbox,
fax,
modem
FROM p_lew_mart_msi.v_org_dl_contact_1;


