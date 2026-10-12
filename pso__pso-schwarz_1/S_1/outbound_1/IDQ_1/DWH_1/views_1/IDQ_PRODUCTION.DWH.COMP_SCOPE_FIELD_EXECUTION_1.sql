CREATE OR REPLACE VIEW idq_production_dwh.comp_scope_field_execution_1 (comp_scope_execution_id, field_definition_id,
execution_date, execution_day_id, match_amount, equal_amount, unequal_amount, leading_empty, dependent_empty, scope_id,
comp_scope_field_execution_is_current, ref_comp_definition_id, leading_comp_scope_id, dependent_comp_scope_id,
leading_ref_source_system_type_id, leading_ref_source_system_id, leading_ref_country_id, leading_ref_branch_id,
leading_ref_test_object_type_id, dependent_ref_source_system_type_id, dependent_ref_source_system_id,
dependent_ref_country_id, dependent_ref_branch_id, dependent_ref_test_object_type_id, sync_score, sync_score_fail,
sync_ratio) AS SELECT A.comp_scope_execution_id,
 A.field_comp_definition_id AS field_definition_id,
 A.execution_date,
 A.execution_day_id,
 A.match_amount,
 A.equal_amount,
 A.unequal_amount,
 A.leading_empty,
 A.dependent_empty,
 A.scope_id,
 1 AS comp_scope_field_execution_is_current,
 RCDS.comp_definition_id AS ref_comp_definition_id,
 RCDS.leading_comp_scope_id,
 RCDS.dependent_comp_scope_id,
 RSL.source_system_type_id AS leading_ref_source_system_type_id,
 RSL.source_system_id AS leading_ref_source_system_id,
 RSL.country_id AS leading_ref_country_id,
 RSL.branch_id AS leading_ref_branch_id,
 RSL.test_object_type_id AS leading_ref_test_object_type_id,
 RSD.source_system_type_id AS dependent_ref_source_system_type_id,
 RSD.source_system_id AS dependent_ref_source_system_id,
 RSD.country_id AS dependent_ref_country_id,
 RSD.branch_id AS dependent_ref_branch_id,
 RSD.test_object_type_id AS dependent_ref_test_object_type_id,
  CASE
  WHEN CAST(A.equal_amount AS NUMERIC) / A.match_amount > 0.5
  THEN 1
  ELSE 0
  END AS sync_score,
  CASE
  WHEN CAST(A.equal_amount AS NUMERIC) / A.match_amount > 0.5
  THEN 0
  ELSE 1
  END AS sync_score_fail,
  CAST(A.equal_amount AS NUMERIC) / A.match_amount AS sync_ratio
FROM idq_production_syscomp.comp_scope_field_execution_current_1 AS A
 INNER JOIN idq_production_syscomp.comp_scope_execution_current_1 AS CSE ON A.comp_scope_execution_id = CSE.id
 INNER JOIN idq_production_idq_results.ref_comp_definition_scope_1 AS RCDS ON CSE.comp_definition_scope_id = RCDS.id
 INNER JOIN idq_production_idq_results.ref_comp_scope_1 AS RSL ON RCDS.leading_comp_scope_id = RSL.id
 INNER JOIN idq_production_idq_results.ref_comp_scope_1 AS RSD ON RCDS.dependent_comp_scope_id = RSD.id
UNION ALL
SELECT AA.comp_scope_execution_id,
 AA.field_comp_definition_id AS field_definition_id,
 AA.execution_date,
 AA.execution_day_id,
 AA.match_amount,
 AA.equal_amount,
 AA.unequal_amount,
 AA.leading_empty,
 AA.dependent_empty,
 AA.scope_id,
 0 AS comp_scope_field_execution_is_current,
 RCDS.comp_definition_id AS ref_comp_definition_id,
 RCDS.leading_comp_scope_id,
 RCDS.dependent_comp_scope_id,
 RSL.source_system_type_id AS leading_ref_source_system_type_id,
 RSL.source_system_id AS leading_ref_source_system_id,
 RSL.country_id AS leading_ref_country_id,
 RSL.branch_id AS leading_ref_branch_id,
 RSL.test_object_type_id AS leading_ref_test_object_type_id,
 RSD.source_system_type_id AS dependent_ref_source_system_type_id,
 RSD.source_system_id AS dependent_ref_source_system_id,
 RSD.country_id AS dependent_ref_country_id,
 RSD.branch_id AS dependent_ref_branch_id,
 RSD.test_object_type_id AS dependent_ref_test_object_type_id,
  CASE
  WHEN CAST(AA.equal_amount AS NUMERIC) / AA.match_amount > 0.5
  THEN 1
  ELSE 0
  END AS sync_score,
  CASE
  WHEN CAST(AA.equal_amount AS NUMERIC) / AA.match_amount > 0.5
  THEN 0
  ELSE 1
  END AS sync_score_fail,
  CAST(AA.equal_amount AS NUMERIC) / AA.match_amount AS sync_ratio
FROM idq_production_syscomp.comp_scope_field_execution_historical_1 AS AA
 INNER JOIN idq_production_syscomp.comp_scope_execution_historical_1 AS CSE ON AA.comp_scope_execution_id = CSE.id
 INNER JOIN idq_production_idq_results.ref_comp_definition_scope_1 AS RCDS ON CSE.comp_definition_scope_id = RCDS.id
 INNER JOIN idq_production_idq_results.ref_comp_scope_1 AS RSL ON RCDS.leading_comp_scope_id = RSL.id
 INNER JOIN idq_production_idq_results.ref_comp_scope_1 AS RSD ON RCDS.dependent_comp_scope_id = RSD.id;