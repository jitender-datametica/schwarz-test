CREATE OR REPLACE VIEW idq_production_dwh.ref_branch_dependent (dependent_ref_branch_id, dependent_branch_name) AS
SELECT id AS dependent_ref_branch_id,
 name AS dependent_branch_name
FROM idq_production_idq_results.ref_branch;