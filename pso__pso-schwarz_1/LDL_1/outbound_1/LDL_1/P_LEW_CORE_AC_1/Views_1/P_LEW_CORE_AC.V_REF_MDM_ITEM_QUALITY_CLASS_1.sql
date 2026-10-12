CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_item_quality_class_1 (item_quality_class_cd, item_quality_class_descr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT item_quality_class_cd,
 item_quality_class_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_item_quality_class_1;