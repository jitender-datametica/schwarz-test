CREATE OR REPLACE VIEW idq_production.idq_results.v_ref_exclude_2 (
    rule_id,
    test_object_id
) AS
SELECT 
    rex.rule_id,
    rex.test_object_id
FROM idq_production.idq_results.ref_exclude_2 AS rex
WHERE 
    rex.exclude_flag = 1 
    AND rex.test_object_id IS NOT NULL;