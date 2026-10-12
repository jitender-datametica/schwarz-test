CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_order_area_2 (client_id, order_area_cd, order_area_descr, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 order_area_cd,
 order_area_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_order_area_2;