CREATE OR REPLACE VIEW process_mining_production_data.v_cel_contract_sla_2 (sys_id, target_display_value, sys_name) AS
SELECT sys_id,
 'Resolution' AS target_display_value,
 sys_name
FROM process_mining_production_etl.t_contract_sla_2
WHERE name LIKE '%resolution';