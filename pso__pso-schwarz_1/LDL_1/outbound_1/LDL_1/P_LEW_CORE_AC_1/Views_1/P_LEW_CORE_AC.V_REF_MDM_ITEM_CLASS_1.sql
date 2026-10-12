CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_item_class_1 (client_id, item_class_cd, item_class, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 item_class_cd,
 item_class,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_item_class_1;