CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_MISS_ITEM_WH_DETAIL
/*
#DescStart#
#$Revision: 7705 $, $LastChangedBy: umeister $
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
    , temp_miss_fg
    , missing_reason_cd
    , missing_reason_desc
)
AS
SELECT
dat_sys,
client_id,
item_id,
orig_item_nr_pp,
wh_id_pp,
end_cd_pp,
aspect_id,
temp_miss_fg,
missing_reason_cd,
missing_reason_desc
FROM p_lew_mart_msi.v_itm_miss_item_wh_detail
;





