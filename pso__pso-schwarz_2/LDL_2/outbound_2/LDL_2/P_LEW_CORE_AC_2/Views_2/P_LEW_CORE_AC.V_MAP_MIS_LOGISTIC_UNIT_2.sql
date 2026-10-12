CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_map_mis_logistic_unit_2 (client_id, uom_cd, mis_logistic_unit_cd, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 uom_cd,
 mis_logistic_unit_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_map_mis_logistic_unit_2;