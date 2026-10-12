CREATE OR REPLACE VIEW idq_production_dwh.idq_test_object_dependent (dependent_idq_test_object_id, ldo_num,
source_system_status, is_relevant, first_unsuccessful_load, ref_time_first_unsuccessful_load_day_id,
idq_test_object_calculation_time, ref_time_calculation_day_id, penalty, score, field_amount, is_usable,
dependent_ref_branch_id, dependent_source_system_primary_key, dependent_ref_source_system_id, dependent_ref_country_id,
dependent_name, dependent_ref_test_object_type_id, dependent_ref_source_system_type_id, dependent_functional_id) AS
SELECT DISTINCT ITO.id AS dependent_idq_test_object_id,
 ITO.ldo_num,
 ITO.source_system_status,
 ITO.is_relevant,
 ITO.first_unsuccessful_load,
 ITO.first_unsuccessful_load_day_id AS ref_time_first_unsuccessful_load_day_id,
 CDTO.calculation_time AS idq_test_object_calculation_time,
 CDTO.calculation_day_id AS ref_time_calculation_day_id,
 CDTO.penalty,
 CDTO.score,
 CDTO.field_amount,
 CDTO.is_usable,
 ITO.branch_id AS dependent_ref_branch_id,
 ITO.source_system_primary_key AS dependent_source_system_primary_key,
 ITO.source_system_id AS dependent_ref_source_system_id,
 ITO.country_id AS dependent_ref_country_id,
 ITO.name AS dependent_name,
 ITO.test_object_type_id AS dependent_ref_test_object_type_id,
 RSS.source_system_type_id AS dependent_ref_source_system_type_id,
  CASE
  WHEN ITO.functional_id IS NULL
  THEN ITO.source_system_primary_key
  ELSE ITO.functional_id
  END AS dependent_functional_id
FROM idq_production_idq_results.idq_test_object AS ITO
 INNER JOIN idq_production_idq_results.ref_source_system AS RSS ON ITO.source_system_id = RSS.id
 LEFT JOIN idq_production_idq_results.check_dq_by_test_object_current AS CDTO ON ITO.id = CDTO.test_object_id
 LEFT JOIN idq_production_syscomp.comp_record_list AS CRL ON ITO.id = CRL.dependent_test_object_id
 LEFT JOIN idq_production_syscomp.comp_field_result_current AS CFR ON ITO.id = CFR.dependent_test_object_id
WHERE CRL.matching_status_id > 1
 OR CFR.is_error_detected = 1;