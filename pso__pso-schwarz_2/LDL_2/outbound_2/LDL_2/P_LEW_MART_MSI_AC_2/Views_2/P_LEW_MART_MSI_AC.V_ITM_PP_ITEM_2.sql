/* #DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_pp_item_2 (client_id, wh_id_pp, picking_area_nr_pp, orig_item_nr_pp,
case_size_pp, item_id, timestamp_from_pp, timestamp_until_pp, dat_sys, end_cd_pp, item_status_pp) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_pp_item_2;