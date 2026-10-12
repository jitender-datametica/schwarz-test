CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_assortment_container_hist_2 (client_id, assortment_container_sid,
assortment_container_int_name, active_fg, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created,
dwh_updated) AS SELECT client_id,
 assortment_container_sid,
 assortment_container_int_name,
 active_fg,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_assortment_container_hist_2;