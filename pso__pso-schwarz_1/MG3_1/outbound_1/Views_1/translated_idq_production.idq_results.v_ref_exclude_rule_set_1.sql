CREATE OR REPLACE VIEW idq_production_idq_results.v_ref_exclude_rule_set_1 (country_id, test_object_type_id,
source_system_id, rule_set) AS SELECT country_id,
 test_object_type_id,
 source_system_id,
  CASE
  WHEN test_object_id IS NOT NULL
  THEN NULL
  ELSE CONCAT('|', STRING_AGG(CAST(rule_id AS STRING), '|' ORDER BY rule_id IS NULL, rule_id), '|')
  END AS rule_set
FROM idq_production_idq_results.ref_exclude_1 AS x
WHERE source_system_primary_key IS NULL
 AND exclude_flag = 1
 AND rule_id IS NOT NULL
 AND source_system_id IS NOT NULL
 AND country_id IS NOT NULL
 AND test_object_type_id IS NOT NULL
GROUP BY country_id,
 test_object_type_id,
 source_system_id,
 test_object_id;