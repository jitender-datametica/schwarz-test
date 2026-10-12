CREATE OR REPLACE VIEW idq_production_dwh.idq_addinfo_hac2_hostgroups_1 (idq_addinfo_hac2_hostgroups_id,
idq_test_object_id, ref_branch_id, source_system_primary_key, source_system_id, ref_country_id, is_relevant, division,
name, application_sit_id_code, application_sit_id_code_2) AS SELECT id AS idq_addinfo_hac2_hostgroups_id,
 test_object_id AS idq_test_object_id,
 branch_id AS ref_branch_id,
 source_system_primary_key,
 source_system_id,
 country_id AS ref_country_id,
 is_relevant,
 division,
 name,
 application_sit_id_code,
 application_sit_id_code_2
FROM idq_production_idq_results.idq_addinfo_hac2_hostgroups_1;