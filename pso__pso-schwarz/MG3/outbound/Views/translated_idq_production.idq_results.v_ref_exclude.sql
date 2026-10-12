CREATE OR REPLACE VIEW idq_production_idq_results.v_ref_exclude (rule_id, test_object_id) AS SELECT rule_id,
 test_object_id
FROM idq_production_idq_results.ref_exclude AS rex
WHERE exclude_flag = 1
 AND test_object_id IS NOT NULL;