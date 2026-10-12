/* #DescStart#
#$Revision: 6244 $, $LastChangedBy: hwieber $
#SubjectAreas#: Organisationsstruktur
#DescEnd# */
CREATE OR REPLACE VIEW ldl_s_conl.v_org_store_merge_1 AS SELECT OSM.loc_sid_store AS store_id,
 OSM.client_id,
 OSM.country_cd,
 OSM.dat_opening,
 OSM.dat_real_opening,
 OSM.dat_closing,
 OSM.dat_valid_from,
 OSM.region_cd,
 OSM.object_nr,
 OSM.licence_nr,
 OSM.pst_lang_cd,
 OSM.mde_print_cd,
 OSM.closed_fg,
 OSM.mde_lang_cd,
 OSM.ord_unit_valid_store_cd,
 OSM.test_store_fg,
 OSM.transfer_fg,
 OSM.store_desc,
 OSM.src_orig_store_nr AS orig_store_nr,
 WH.src_wh_id AS wh_id,
 OSM.cnt_open_days,
 OSM.qty_min_dflt,
 OSM.dat_calc_start_py,
 OSM.dat_calc_end_py,
 OSM.dat_calc_start_ppy,
 OSM.dat_opening_ovis,
 OSM.dat_closing_ovis,
 OSM.objectstatus_id,
 OSM.mis_store_active_fg,
 OSM.loc_sid_store_move_to AS move_to_store_id,
 OSM.move_fg,
 OSM.aspect_id
FROM ldl_p_lew_bil_ac.v_org_store_merge_1 AS OSM
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON OSM.loc_sid_wh = WH.loc_sid_wh AND OSM.client_id = WH.client_id AND WH
   .dwh_actual_fg = 1
WHERE OSM.client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_1
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));


/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_org_store_act_1", "p_lew_core_ac.v_wawi_org_all_store_reloc_act_1", "p_lew_bil_ac.v_warehouse_1", "p_lew_bil_ac.v_store_1", "p_lew_core_ac.v_wawi_ref_client_country_1", "p_lew_core_ac.v_wawi_ref_country_1" ***/