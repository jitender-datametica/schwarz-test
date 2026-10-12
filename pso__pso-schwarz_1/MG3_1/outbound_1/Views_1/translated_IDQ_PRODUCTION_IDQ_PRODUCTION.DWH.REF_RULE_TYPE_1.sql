CREATE OR REPLACE VIEW idq_production_dwh.ref_rule_type_1 (ref_rule_type_id, rule_type_technical_name, rule_type_name,
rule_type_name_de, rule_type_name_en) AS SELECT id AS ref_rule_type_id,
 rule_type AS rule_type_technical_name,
 name_de AS rule_type_name,
 name_de AS rule_type_name_de,
 name_en AS rule_type_name_en
FROM idq_production_idq_results.ref_rule_type_1;