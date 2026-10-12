/* #DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_day_miss_item_wh_1 (dat_sys, client_id, wh_id_pp, aspect_id, item_id,
orig_item_nr_pp) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_day_miss_item_wh_1;