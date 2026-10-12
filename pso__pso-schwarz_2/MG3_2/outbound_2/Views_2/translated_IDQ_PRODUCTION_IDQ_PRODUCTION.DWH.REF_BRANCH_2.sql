CREATE OR REPLACE VIEW idq_production_dwh.ref_branch_2 (ref_branch_id, branch_name) AS SELECT id AS ref_branch_id,
 name AS branch_name
FROM idq_production_idq_results.ref_branch_2;