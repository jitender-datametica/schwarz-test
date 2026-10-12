CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_campaign_element_relation_type_1 (campaign_elem_rel_type_cd,
campaign_elem_rel_type_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT campaign_elem_rel_type_cd,
 campaign_elem_rel_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_campaign_element_relation_type_1;