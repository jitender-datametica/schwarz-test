CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_PP_ITEM
/*
#DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
client_id
, wh_id_pp
, picking_area_nr_pp
, orig_item_nr_pp
, case_size_pp
, item_id
, timestamp_from_pp
, timestamp_until_pp
, dat_sys
, end_cd_pp
, item_status_pp
 )
AS
SELECT
client_id,
wh_id_pp,
picking_area_nr_pp,
orig_item_nr_pp,
case_size_pp,
item_id,
timestamp_from_pp,
timestamp_until_pp,
dat_sys,
end_cd_pp,
item_status_pp
FROM p_lew_mart_msi.v_itm_pp_item;


