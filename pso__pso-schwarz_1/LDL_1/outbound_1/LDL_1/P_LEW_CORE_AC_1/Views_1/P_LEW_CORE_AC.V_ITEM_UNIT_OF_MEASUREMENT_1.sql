CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_unit_of_measurement_1 (client_id, item_sid, uom_sid, uom_cd, log_var_cd,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_sid,
 uom_sid,
 uom_cd,
 log_var_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_unit_of_measurement_1;