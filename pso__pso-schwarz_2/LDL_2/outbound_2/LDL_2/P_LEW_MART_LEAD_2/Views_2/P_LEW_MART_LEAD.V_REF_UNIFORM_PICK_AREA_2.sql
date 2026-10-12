/*
 * Standard mapping of picking area
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_uniform_pick_area_2 (pick_area_nr, pick_area_descr, pick_main_area_nr) AS
SELECT pick_area_nr,
 pick_area_descr,
 pick_main_area_nr
FROM ldl_p_lew_core_ac.v_ref_uniform_pick_area_2;