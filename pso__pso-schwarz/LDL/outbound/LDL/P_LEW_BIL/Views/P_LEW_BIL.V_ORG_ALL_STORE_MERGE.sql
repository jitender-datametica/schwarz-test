CREATE OR REPLACE VIEW ldl_p_lew_bil.v_org_all_store_merge (aspect_id, client_id, move_to_store_id, move_store_desc,
wh_id, loc_sid_wh, wh_id_exp, loc_sid_wh_exp, sales_manager_id, dat_closing_ovis, dat_opening_ovis, mis_store_active_fg
, dat_opening, dat_closing, orig_store_nr, dat_calc_start_py, dat_calc_end_py, objectstatus_id, dat_calc_start_ppy,
move_fg, street, zipcode, city, phone, longitude, latitude) AS SELECT OSM.aspect_id,
 OSM.client_id,
 OSM.move_to_st_loc_sid AS move_to_store_id,
 OSM.move_store_desc,
 WH.src_wh_id AS wh_id,
 WH.loc_sid_wh,
 WH2.src_wh_id AS wh_id_exp,
 WH2.loc_sid_wh AS loc_sid_wh_exp,
 OSM.sales_manager_id,
 OSM.dat_closing_ovis,
 OSM.dat_opening_ovis,
 OSM.mis_store_active_fg,
 OSM.dat_opening,
 OSM.dat_closing,
 OSM.orig_store_nr,
 OSM.dat_calc_start_py,
 OSM.dat_calc_end_py,
 OSM.objectstatus_id,
 OSM.dat_calc_start_ppy,
 OSM.move_fg,
 OSM.street,
 OSM.zipcode,
 OSM.city,
 OSM.phone,
 OSM.longitude,
 OSM.latitude
FROM ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act AS OSM
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON OSM.wh_loc_sid = WH.loc_sid_wh AND OSM.client_id = WH.client_id AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH2 ON OSM.wh_loc_sid_exp = WH2.loc_sid_wh AND OSM.client_id = WH2.client_id
     AND WH2.dwh_actual_fg = 1;