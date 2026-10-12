CREATE OR REPLACE VIEW s_conl.v_org_store_merge
AS
/*
#DescStart#
#$Revision: 6244 $, $LastChangedBy: hwieber $
#SubjectAreas#: Organisationsstruktur
#DescEnd#
*/
SELECT
osm.loc_sid_store                       AS store_id,
osm.client_id,
osm.country_cd,
osm.dat_opening,
osm.dat_real_opening,
osm.dat_closing,
osm.dat_valid_from,
osm.region_cd,
osm.object_nr,
osm.licence_nr,
osm.pst_lang_cd,
osm.mde_print_cd,
osm.closed_fg,
osm.mde_lang_cd,
osm.ord_unit_valid_store_cd,
osm.test_store_fg,
osm.transfer_fg,
osm.store_desc,
osm.src_orig_store_nr                 AS orig_store_nr,
wh.src_wh_id                          AS wh_id,
osm.cnt_open_days,
osm.qty_min_dflt,
osm.dat_calc_start_py,
osm.dat_calc_end_py,
osm.dat_calc_start_ppy,
osm.dat_opening_ovis,
osm.dat_closing_ovis,
osm.objectstatus_id,
osm.mis_store_active_fg,
osm.loc_sid_store_move_to             AS move_to_store_id,
osm.move_fg,
osm.aspect_id
FROM p_lew_bil_ac.v_org_store_merge osm

INNER JOIN p_lew_bil_ac.v_warehouse wh
ON osm.loc_sid_wh = wh.loc_sid_wh
AND osm.client_id = wh.client_id
AND wh.dwh_actual_fg = 1

WHERE osm.client_id IN
	(SELECT
client_id
FROM s_conl.t_user_mapping WHERE lower(user_name) = lower(current_user));

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_org_store_act", "p_lew_core_ac.v_wawi_org_all_store_reloc_act", "p_lew_bil_ac.v_warehouse", "p_lew_bil_ac.v_store", "p_lew_core_ac.v_wawi_ref_client_country", "p_lew_core_ac.v_wawi_ref_country" ***/

