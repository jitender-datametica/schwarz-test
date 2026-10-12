CREATE OR REPLACE VIEW ldl_p_lew_bil.v_itm_pp_picking_main_area_2 AS SELECT client_id,
 loc_sid AS wh_id_pp,
 pick_area_id AS picking_area_nr_pp,
 pick_main_area_id AS picking_main_area_nr_pp,
 pick_main_area_descr AS picking_main_area_desc_pp
FROM ldl_p_lew_core_ac.v_ref_pick_area_descr_2
WHERE lang_sid = 2;