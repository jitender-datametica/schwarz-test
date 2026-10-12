CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_pmr_kfl_action_item_1 (idq_addinfo_pmr_kfl_item_id,
idq_test_object_id, ref_branch_id, source_system_primary_key, promotion, item_1, ref_source_system_id, ref_country_id,
is_relevant, dmf_ofr_ref_event_id, dmf_ofr_ext_xr_ext_ofr_id, dmf_ofr_changed_on, timestamp_from, timestamp_to) AS
SELECT id AS idq_addinfo_pmr_kfl_item_id,
 test_object_id AS idq_test_object_id,
 branch_id AS ref_branch_id,
 source_system_primary_key,
 promotion,
 item_1,
 source_system_id AS ref_source_system_id,
 country_id AS ref_country_id,
 is_relevant,
 dmf_ofr_ref_event_id,
 dmf_ofr_ext_xr_ext_ofr_id,
 dmf_ofr_changed_on,
 timestamp_from,
 timestamp_to
FROM idq_production_idq_results.idq_addinfo_pmr_kfl_action_item_1;