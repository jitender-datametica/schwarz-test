CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_wh_management_region_2 (client_id, wh_loc_sid, managing_board_int,
managing_director_sales, managing_director_region, region_id, load_id) AS SELECT client_id,
 wh_loc_sid,
 managing_board_int,
 managing_director_sales,
 managing_director_region,
 region_id,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_wh_management_region_2;