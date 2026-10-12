CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_MISS_ITEM_WH_1
/*
#DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
dat_sys
, client_id
, item_id
, orig_item_nr_pp
, wh_id_pp
, end_cd_pp
, aspect_id
 )
AS
SELECT
dat_sys,
client_id,
item_id,
orig_item_nr_pp,
wh_id_pp,
end_cd_pp,
aspect_id
FROM p_lew_mart_msi.v_itm_miss_item_wh_1;


