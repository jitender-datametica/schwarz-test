CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_campaign_plan_type_1 (campaign_element_plan_type_cd,
campaign_element_plan_type_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT campaign_element_plan_type_cd,
 campaign_element_plan_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_campaign_plan_type_1;