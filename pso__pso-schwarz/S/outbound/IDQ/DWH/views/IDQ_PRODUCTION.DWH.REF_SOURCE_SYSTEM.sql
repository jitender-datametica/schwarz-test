CREATE OR REPLACE VIEW idq_production_dwh.ref_source_system (ref_source_system_id, source_system_name,
ref_source_system_type_id, parent_id) AS SELECT id AS ref_source_system_id,
 source_system AS source_system_name,
 source_system_type_id AS ref_source_system_type_id,
 parent_id
FROM idq_production_idq_results.ref_source_system;