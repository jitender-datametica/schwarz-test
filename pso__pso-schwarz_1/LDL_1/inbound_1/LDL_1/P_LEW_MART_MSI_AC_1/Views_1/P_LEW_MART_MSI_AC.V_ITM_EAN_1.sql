CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_EAN_1
/*
#DescStart#
#$Revision: 6699 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
client_id
, item_id
, ean_1
, ean_item_desc
, language_id
 )
AS
SELECT
client_id,
item_id,
ean_1,
ean_item_desc,
language_id
FROM p_lew_mart_msi.v_itm_ean_1;


