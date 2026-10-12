CREATE OR REPLACE VIEW idq_production_dwh.ref_rel_rule_group_rule (ref_rel_rule_group_rule_id, ref_rule_group_id,
ref_rule_id, ref_source_system_type_id, ref_field_id) AS SELECT rrgr.id AS ref_rel_rule_group_rule_id,
 rrgr.rule_group_id AS ref_rule_group_id,
 rrgr.rule_id AS ref_rule_id,
 f.source_system_type_id AS ref_source_system_type_id,
 r.field_id AS ref_field_id
FROM idq_production_idq_results.ref_rel_rule_group_rule AS rrgr
 INNER JOIN idq_production_idq_results.ref_rule AS r ON rrgr.rule_id = r.id
 INNER JOIN idq_production_idq_results.ref_field AS f ON r.field_id = f.id;