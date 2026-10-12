CREATE OR REPLACE VIEW idq_production_dwh.ref_rule_group (ref_rule_group_id, ref_source_system_type_id,
rule_group_technical_name, rule_group_name, rule_group_name_de, rule_group_name_en) AS SELECT id AS ref_rule_group_id,
 source_system_type_id AS ref_source_system_type_id,
 short_name AS rule_group_technical_name,
 name_de AS rule_group_name,
 name_de AS rule_group_name_de,
 name_es AS rule_group_name_en
FROM idq_production_idq_results.ref_rule_group;