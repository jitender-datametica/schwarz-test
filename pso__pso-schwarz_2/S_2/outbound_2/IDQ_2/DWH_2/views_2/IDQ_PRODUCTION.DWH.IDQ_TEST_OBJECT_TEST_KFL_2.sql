CREATE OR REPLACE VIEW idq_production_dwh.idq_test_object_test_kfl_2 (idq_test_object_id, ref_branch_id,
source_system_primary_key, functional_id, ref_source_system_id, ldo_num, ref_country_id, name, ref_test_object_type_id,
source_system_status, is_relevant, last_update, first_unsuccessful_load, ref_time_first_unsuccessful_load_day_id,
ref_source_system_type_id, idq_test_object_calculation_time, ref_time_calculation_day_id, penalty, score, field_amount,
is_usable) AS SELECT ITO.id AS idq_test_object_id,
 ITO.branch_id AS ref_branch_id,
 ITO.source_system_primary_key,
  CASE
  WHEN ITO.functional_id IS NULL
  THEN ITO.source_system_primary_key
  ELSE ITO.functional_id
  END AS functional_id,
 ITO.source_system_id AS ref_source_system_id,
 ITO.ldo_num,
 ITO.country_id AS ref_country_id,
 ITO.name,
 ITO.test_object_type_id AS ref_test_object_type_id,
 ITO.source_system_status,
 ITO.is_relevant,
 ITO.last_update,
 ITO.first_unsuccessful_load,
 ITO.first_unsuccessful_load_day_id AS ref_time_first_unsuccessful_load_day_id,
 RSS.source_system_type_id AS ref_source_system_type_id,
 CDTO.calculation_time AS idq_test_object_calculation_time,
 CDTO.calculation_day_id AS ref_time_calculation_day_id,
 CDTO.penalty,
 CDTO.score,
 CDTO.field_amount,
 CDTO.is_usable
FROM idq_production_idq_results.idq_test_object_2 AS ITO
 INNER JOIN idq_production_idq_results.ref_source_system_2 AS RSS ON ITO.source_system_id = RSS.id
 LEFT JOIN idq_production_idq_results.check_dq_by_test_object_current_2 AS CDTO ON ITO.id = CDTO.test_object_id
WHERE RSS.source_system_type_id = 14;