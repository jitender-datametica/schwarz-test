CREATE OR REPLACE VIEW idq_production_dwh.idq_test_object_leading_2 (leading_idq_test_object_id, ref_branch_id,
source_system_primary_key, ref_source_system_id, ldo_num, ref_country_id, name, ref_test_object_type_id,
source_system_status, is_relevant, first_unsuccessful_load, ref_time_first_unsuccessful_load_day_id,
ref_source_system_type_id, idq_test_object_calculation_time, ref_time_calculation_day_id, penalty, score, field_amount,
is_usable, leading_functional_id) AS SELECT DISTINCT ITO.id AS leading_idq_test_object_id,
 ITO.branch_id AS ref_branch_id,
 ITO.source_system_primary_key,
 ITO.source_system_id AS ref_source_system_id,
 ITO.ldo_num,
 ITO.country_id AS ref_country_id,
 ITO.name,
 ITO.test_object_type_id AS ref_test_object_type_id,
 ITO.source_system_status,
 ITO.is_relevant,
 ITO.first_unsuccessful_load,
 ITO.first_unsuccessful_load_day_id AS ref_time_first_unsuccessful_load_day_id,
 RSS.source_system_type_id AS ref_source_system_type_id,
 CDTO.calculation_time AS idq_test_object_calculation_time,
 CDTO.calculation_day_id AS ref_time_calculation_day_id,
 CDTO.penalty,
 CDTO.score,
 CDTO.field_amount,
 CDTO.is_usable,
  CASE
  WHEN ITO.functional_id IS NULL
  THEN ITO.source_system_primary_key
  ELSE ITO.functional_id
  END AS leading_functional_id
FROM idq_production_idq_results.idq_test_object_2 AS ITO
 INNER JOIN idq_production_idq_results.ref_source_system_2 AS RSS ON ITO.source_system_id = RSS.id
 LEFT JOIN idq_production_idq_results.check_dq_by_test_object_current_2 AS CDTO ON ITO.id = CDTO.test_object_id
 LEFT JOIN idq_production_syscomp.comp_record_list_2 AS CRL ON ITO.id = CRL.leading_test_object_id
 LEFT JOIN idq_production_syscomp.comp_field_result_current_2 AS CFR ON ITO.id = CFR.leading_test_object_id
WHERE CRL.matching_status_id > 1
 OR CFR.is_error_detected = 1;