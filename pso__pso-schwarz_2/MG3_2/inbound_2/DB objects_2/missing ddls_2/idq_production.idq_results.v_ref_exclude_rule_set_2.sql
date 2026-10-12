CREATE OR REPLACE VIEW idq_production.idq_results.v_ref_exclude_rule_set_2 (
    country_id,
    test_object_type_id,
    source_system_id,
    rule_set
) AS
SELECT 
    country_id,
    test_object_type_id,
    source_system_id,
    CASE 
        WHEN test_object_id IS NOT NULL THEN NULL 
        ELSE CONCAT('|', LISTAGG(rule_id, '|') WITHIN GROUP (ORDER BY rule_id), '|')
    END
FROM idq_production.idq_results.ref_exclude_2 AS x
WHERE 
    rule_id IS NOT NULL
    AND source_system_primary_key IS NULL
    AND source_system_id IS NOT NULL
    AND country_id IS NOT NULL
    AND test_object_type_id IS NOT NULL
    AND exclude_flag = 1
GROUP BY 
    country_id,
    test_object_type_id,
    source_system_id,
    test_object_id;