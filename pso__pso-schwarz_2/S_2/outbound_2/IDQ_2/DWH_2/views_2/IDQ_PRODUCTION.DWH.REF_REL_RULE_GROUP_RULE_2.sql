CREATE OR REPLACE VIEW idq_production_dwh.ref_rel_rule_group_rule_2 (ref_rel_rule_group_rule_id, ref_rule_group_id,
ref_rule_id, ref_source_system_type_id, ref_field_id) AS SELECT RRGR.id AS ref_rel_rule_group_rule_id,
 RRGR.rule_group_id AS ref_rule_group_id,
 RRGR.rule_id AS ref_rule_id,
 F.source_system_type_id AS ref_source_system_type_id,
 R.field_id AS ref_field_id
FROM idq_production_idq_results.ref_rel_rule_group_rule_2 AS RRGR
 INNER JOIN idq_production_idq_results.ref_rule_2 AS R ON RRGR.rule_id = R.id
 INNER JOIN idq_production_idq_results.ref_field_2 AS F ON R.field_id = F.id;