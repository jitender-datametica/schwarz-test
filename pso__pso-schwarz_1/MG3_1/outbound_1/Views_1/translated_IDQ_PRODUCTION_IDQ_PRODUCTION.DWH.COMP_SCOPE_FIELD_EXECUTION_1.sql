CREATE OR REPLACE VIEW idq_production_dwh.comp_scope_field_execution_1 (comp_scope_execution_id, field_definition_id,
execution_date, execution_day_id, match_amount, equal_amount, unequal_amount, leading_empty, dependent_empty, scope_id,
comp_scope_field_execution_is_current, ref_comp_definition_id, leading_comp_scope_id, dependent_comp_scope_id,
leading_ref_source_system_type_id, leading_ref_source_system_id, leading_ref_country_id, leading_ref_branch_id,
leading_ref_test_object_type_id, dependent_ref_source_system_type_id, dependent_ref_source_system_id,
dependent_ref_country_id, dependent_ref_branch_id, dependent_ref_test_object_type_id, sync_score, sync_score_fail,
sync_ratio) AS SELECT a.comp_scope_execution_id,
 a.field_comp_definition_id AS field_definition_id,
 a.execution_date,
 a.execution_day_id,
 a.match_amount,
 a.equal_amount,
 a.unequal_amount,
 a.leading_empty,
 a.dependent_empty,
 a.scope_id,
 1 AS comp_scope_field_execution_is_current,
 rcds.comp_definition_id AS ref_comp_definition_id,
 rcds.leading_comp_scope_id,
 rcds.dependent_comp_scope_id,
 rsl.source_system_type_id AS leading_ref_source_system_type_id,
 rsl.source_system_id AS leading_ref_source_system_id,
 rsl.country_id AS leading_ref_country_id,
 rsl.branch_id AS leading_ref_branch_id,
 rsl.test_object_type_id AS leading_ref_test_object_type_id,
 rsd.source_system_type_id AS dependent_ref_source_system_type_id,
 rsd.source_system_id AS dependent_ref_source_system_id,
 rsd.country_id AS dependent_ref_country_id,
 rsd.branch_id AS dependent_ref_branch_id,
 rsd.test_object_type_id AS dependent_ref_test_object_type_id,
  CASE
  WHEN CAST(a.equal_amount AS BIGNUMERIC) / a.match_amount > 0.5
  THEN 1
  ELSE 0
  END AS sync_score,
  CASE
  WHEN CAST(a.equal_amount AS BIGNUMERIC) / a.match_amount > 0.5
  THEN 0
  ELSE 1
  END AS sync_score_fail,
  CAST(a.equal_amount AS BIGNUMERIC) / a.match_amount AS sync_ratio
FROM idq_production_syscomp.comp_scope_field_execution_current_1 AS a
 INNER JOIN idq_production_syscomp.comp_scope_execution_current_1 AS cse ON a.comp_scope_execution_id = cse.id
 INNER JOIN idq_production_idq_results.ref_comp_definition_scope_1 AS rcds ON cse.comp_definition_scope_id = rcds.id
 INNER JOIN idq_production_idq_results.ref_comp_scope_1 AS rsl ON rcds.leading_comp_scope_id = rsl.id
 INNER JOIN idq_production_idq_results.ref_comp_scope_1 AS rsd ON rcds.dependent_comp_scope_id = rsd.id
UNION ALL
SELECT aa.comp_scope_execution_id,
 aa.field_comp_definition_id AS field_definition_id,
 aa.execution_date,
 aa.execution_day_id,
 aa.match_amount,
 aa.equal_amount,
 aa.unequal_amount,
 aa.leading_empty,
 aa.dependent_empty,
 aa.scope_id,
 0 AS comp_scope_field_execution_is_current,
 rcds.comp_definition_id AS ref_comp_definition_id,
 rcds.leading_comp_scope_id,
 rcds.dependent_comp_scope_id,
 rsl.source_system_type_id AS leading_ref_source_system_type_id,
 rsl.source_system_id AS leading_ref_source_system_id,
 rsl.country_id AS leading_ref_country_id,
 rsl.branch_id AS leading_ref_branch_id,
 rsl.test_object_type_id AS leading_ref_test_object_type_id,
 rsd.source_system_type_id AS dependent_ref_source_system_type_id,
 rsd.source_system_id AS dependent_ref_source_system_id,
 rsd.country_id AS dependent_ref_country_id,
 rsd.branch_id AS dependent_ref_branch_id,
 rsd.test_object_type_id AS dependent_ref_test_object_type_id,
  CASE
  WHEN CAST(aa.equal_amount AS BIGNUMERIC) / aa.match_amount > 0.5
  THEN 1
  ELSE 0
  END AS sync_score,
  CASE
  WHEN CAST(aa.equal_amount AS BIGNUMERIC) / aa.match_amount > 0.5
  THEN 0
  ELSE 1
  END AS sync_score_fail,
  CAST(aa.equal_amount AS BIGNUMERIC) / aa.match_amount AS sync_ratio
FROM idq_production_syscomp.comp_scope_field_execution_historical_1 AS aa
 INNER JOIN idq_production_syscomp.comp_scope_execution_historical_1 AS cse ON aa.comp_scope_execution_id = cse.id
 INNER JOIN idq_production_idq_results.ref_comp_definition_scope_1 AS rcds ON cse.comp_definition_scope_id = rcds.id
 INNER JOIN idq_production_idq_results.ref_comp_scope_1 AS rsl ON rcds.leading_comp_scope_id = rsl.id
 INNER JOIN idq_production_idq_results.ref_comp_scope_1 AS rsd ON rcds.dependent_comp_scope_id = rsd.id;