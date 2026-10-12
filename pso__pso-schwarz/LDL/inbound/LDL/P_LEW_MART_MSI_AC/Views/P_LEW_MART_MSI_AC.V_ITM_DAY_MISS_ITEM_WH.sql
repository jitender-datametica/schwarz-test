CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_DAY_MISS_ITEM_WH
/*
#DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
dat_sys
, client_id
, wh_id_pp
, aspect_id
, item_id
, orig_item_nr_pp
 )
AS
SELECT
dat_sys,
client_id,
wh_id_pp,
aspect_id,
item_id,
orig_item_nr_pp
FROM p_lew_mart_msi.v_itm_day_miss_item_wh;






