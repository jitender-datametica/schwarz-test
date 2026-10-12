CREATE OR REPLACE VIEW idq_production_dwh.mstr_cube_1 (cube_id, mstr_cube_id, mstr_project_id, mstr_cube_name,
ref_source_system_type_id) AS SELECT id AS cube_id,
 mstr_cube_id,
 mstr_project_id,
 mstr_cube_name,
 source_system_type_id AS ref_source_system_type_id
FROM idq_production_scheduler.mstr_cube_1;