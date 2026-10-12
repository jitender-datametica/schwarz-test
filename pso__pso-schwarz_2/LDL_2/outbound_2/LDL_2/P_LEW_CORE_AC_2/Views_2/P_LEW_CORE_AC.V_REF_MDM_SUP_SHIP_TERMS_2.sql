CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_sup_ship_terms_2 (client_id, sup_ship_terms_cd, sup_ship_terms,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 sup_ship_terms_cd,
 sup_ship_terms,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_sup_ship_terms_2;