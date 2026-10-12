CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_itm_pp_picking_main_area (client_id, wh_id_pp, picking_area_nr_pp,
picking_main_area_nr_pp, picking_main_area_desc_pp) AS SELECT *
FROM ldl_p_lew_bil.v_itm_pp_picking_main_area;