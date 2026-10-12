CREATE OR REPLACE VIEW idq_production_dwh.idq_test_object_dependent_1 (dependent_idq_test_object_id, ldo_num,
source_system_status, is_relevant, first_unsuccessful_load, ref_time_first_unsuccessful_load_day_id,
idq_test_object_calculation_time, ref_time_calculation_day_id, penalty, score, field_amount, is_usable,
dependent_ref_branch_id, dependent_source_system_primary_key, dependent_ref_source_system_id, dependent_ref_country_id,
dependent_name, dependent_ref_test_object_type_id, dependent_ref_source_system_type_id, dependent_functional_id) AS
SELECT DISTINCT ito.id AS dependent_idq_test_object_id,
 ito.ldo_num,
 ito.source_system_status,
 ito.is_relevant,
 ito.first_unsuccessful_load,
 ito.first_unsuccessful_load_day_id AS ref_time_first_unsuccessful_load_day_id,
 cdto.calculation_time AS idq_test_object_calculation_time,
 cdto.calculation_day_id AS ref_time_calculation_day_id,
 cdto.penalty,
 cdto.score,
 cdto.field_amount,
 cdto.is_usable,
 ito.branch_id AS dependent_ref_branch_id,
 ito.source_system_primary_key AS dependent_source_system_primary_key,
 ito.source_system_id AS dependent_ref_source_system_id,
 ito.country_id AS dependent_ref_country_id,
 ito.name AS dependent_name,
 ito.test_object_type_id AS dependent_ref_test_object_type_id,
 rss.source_system_type_id AS dependent_ref_source_system_type_id,
  CASE
  WHEN ito.functional_id IS NULL
  THEN ito.source_system_primary_key
  ELSE ito.functional_id
  END AS dependent_functional_id
FROM idq_production_idq_results.idq_test_object_1 AS ito
 INNER JOIN idq_production_idq_results.ref_source_system_1 AS rss ON ito.source_system_id = rss.id
 LEFT JOIN idq_production_idq_results.check_dq_by_test_object_current_1 AS cdto ON ito.id = cdto.test_object_id
 LEFT JOIN idq_production_syscomp.comp_record_list_1 AS crl ON ito.id = crl.dependent_test_object_id
 LEFT JOIN idq_production_syscomp.comp_field_result_current_1 AS cfr ON ito.id = cfr.dependent_test_object_id
WHERE crl.matching_status_id > 1
 OR cfr.is_error_detected = 1;