CREATE OR REPLACE VIEW process_mining_production_data.v_cel_inc_prb_matching__1week_gb_2 (number, problem_number) AS
SELECT number,
 problem_number
FROM process_mining_production_data.v_cel_incident_1week_gb_2
WHERE problem_number IS NOT NULL;