CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_itm_item_wh_1 AS
SELECT A.client_id,
 F.src_wh_id AS wh_id,
 A.item_sid AS item_id,
 B.pallet_factor_dus AS case_factor_dd,
 B.pallet_factor AS case_factor_euro,
 E.case_factor_layer,
 E.case_size_dec,
 E.dir_delete_fg,
 E.forwarding_item_nr,
 E.fresh_control_fg,
 COALESCE(R.mis_itm_state_id, E.item_status) AS status_id,
 E.item_status_reason,
 E.item_status_updated_by,
 E.min_orderunit,
 E.min_case_dd_wh,
 E.min_case_euro_wh,
 E.min_case_wh,
 E.min_case_layer_wh,
 E.order_area_cd,
 E.pallet_target_height_go,
 E.pallet_feet_height_go,
 E.pallet_factor_go,
 E.poster_fg,
 E.price_sign_fg,
 E.price_strip_fg,
 E.min_orderunit_desc,
 E.min_orderunit_short_desc,
 E.superstructure_item_fg,
 E.timestamp_status_updated
FROM ldl_p_lew_bil_ac.v_item_1 AS A
 INNER JOIN ldl_p_lew_core_ac.v_item_info_per_location_hist_1 AS B ON A.client_id = B.client_id AND A.item_sid = B.item_sid
      AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to AND B.deleted_fg = 0
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS F ON A.client_id = F.client_id AND B.loc_sid = F.loc_sid_wh AND F.dwh_actual_fg
      = 1 AND F.deleted_fg = 0 AND F.bges_active_fg = 1
 LEFT JOIN ldl_p_lew_core_ac.v_map_mis_item_status_1 AS R ON B.client_id = R.client_id AND B.item_status_cd = R.item_status_cd
   
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_wh_1 AS E ON B.client_id = E.client_id AND B.item_sid = E.item_sid AND B.loc_sid
     = E.wh_loc_sid AND CURRENT_DATE BETWEEN E.dat_rec_start AND E.dat_rec_end
WHERE A.dwh_actual_fg = 1;