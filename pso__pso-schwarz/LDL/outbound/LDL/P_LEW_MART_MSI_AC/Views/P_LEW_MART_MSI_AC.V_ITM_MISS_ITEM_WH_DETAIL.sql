/* #DescStart#
#$Revision: 7705 $, $LastChangedBy: umeister $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_miss_item_wh_detail (dat_sys, client_id, item_id, orig_item_nr_pp,
wh_id_pp, end_cd_pp, aspect_id, temp_miss_fg, missing_reason_cd, missing_reason_desc) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_miss_item_wh_detail;