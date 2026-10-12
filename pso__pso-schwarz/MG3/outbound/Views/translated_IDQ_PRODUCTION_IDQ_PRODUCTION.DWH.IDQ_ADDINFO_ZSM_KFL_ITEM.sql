CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_zsm_kfl_item (idq_addinfo_zsm_kfl_item_id, idq_test_object_id,
ref_branch_id, source_system_primary_key, ref_source_system_id, ref_country_id, is_relevant, zsm_matnr, zsm_mstae,
zsm_wekgr) AS SELECT id AS idq_addinfo_zsm_kfl_item_id,
 test_object_id AS idq_test_object_id,
 branch_id AS ref_branch_id,
 source_system_primary_key,
 source_system_id AS ref_source_system_id,
 country_id AS ref_country_id,
 is_relevant,
 zsm_matnr,
 zsm_mstae,
 zsm_wekgr
FROM idq_production_idq_results.idq_addinfo_zsm_kfl_item;