CREATE OR REPLACE VIEW process_mining_production_data.v_cel_incident_1 (number, short_description, description,
close_notes, close_code, assignment_group, assignment_group_display_value, sourcesystem, assigned_to_display_value,
opened_by_display_value, contact_type_display_value, category, subcategory, cmdb_ci_display_value,
business_service_display_value, location_display_value, priority_display_value, impact_display_value,
urgency_display_value, region_u_code, division_u_name, reopen_count, state_display_value, opened_at, closed_at, sys_id,
sys_updated_on, problem_number) AS SELECT TICKET.number,
 TICKET.short_description,
 TICKET.description,
 TICKET.u_solution AS close_notes,
 ticket_mapping_close_code.matching AS close_code,
 TICKET.assignment_group,
 ASSIGNED_GROUP.name AS assignment_group_display_value,
 'IT4YOU' AS sourcesystem,
 NULL AS assigned_to_display_value,
 NULL AS opened_by_display_value,
 ticket_mapping_source.matching AS contact_type_display_value,
 NULL AS category,
 NULL AS subcategory,
 CMDB.name AS cmdb_ci_display_value,
 NULL AS business_service_display_value,
 LOCATION.u_code AS location_display_value,
 TICKET.priority AS priority_display_value,
 NULL AS impact_display_value,
 NULL AS urgency_display_value,
 COALESCE(t_u_business_region.u_code, FIRST_GROUP.region_code) AS region_u_code,
 COALESCE(t_u_division.u_name, FIRST_GROUP.divison_name) AS division_u_name,
 TICKET.reopen_count,
 ticket_mapping_state.matching AS state_display_value,
 TICKET.opened_at,
 TICKET.closed_at,
 TICKET.sys_id,
 TICKET.sys_updated_on,
 t_problem.number AS problem_number
FROM process_mining_production_etl.t_incident_1 AS TICKET
 LEFT JOIN process_mining_production_etl.v_user_group_1 AS ASSIGNED_GROUP ON TICKET.assignment_group = ASSIGNED_GROUP.sys_id
  
 LEFT JOIN process_mining_production_etl.ticket_mapping_source_1 ON TICKET.u_source = ticket_mapping_source.raw_data_source
    AND 'incident' = ticket_mapping_source.sys_class_name
 LEFT JOIN process_mining_production_etl.ticket_mapping_close_code_1 ON TICKET.u_close_code = ticket_mapping_close_code.raw_data_close_code
    AND 'incident' = ticket_mapping_close_code.sys_class_name
 LEFT JOIN process_mining_production_etl.ticket_mapping_state_1 ON TICKET.state = CAST(ticket_mapping_state.raw_data_state AS FLOAT64)
    AND TICKET.sys_class_name = ticket_mapping_state.sys_class_name
 LEFT JOIN process_mining_production_etl.t_cmdb_ci_1 AS CMDB ON TICKET.cmdb_ci = CMDB.sys_id
 LEFT JOIN process_mining_production_etl.t_cmn_location_1 AS LOCATION_1 ON TICKET.location_1 = LOCATION.sys_id
 LEFT JOIN process_mining_production_etl.t_u_division_1 ON TICKET.u_division = t_u_division.sys_id
 LEFT JOIN process_mining_production_etl.t_u_division_business_region_1 ON TICKET.u_division_business_region =
  t_u_division_business_region.sys_id
 LEFT JOIN process_mining_production_etl.t_u_business_region_1 ON TICKET.u_region = t_u_business_region.sys_id
 LEFT JOIN process_mining_production_etl.v_user_group_1 AS FIRST_GROUP ON TICKET.u_first_assignment_group = FIRST_GROUP.sys_id
  
 LEFT JOIN process_mining_production_etl.t_problem_1 ON TICKET.problem_id = t_problem.sys_id
WHERE TICKET.sys_created_on >= CAST('2024-03-01 00:00:00' AS DATETIME)
 AND TICKET.sys_created_on <= CAST('2025-09-30 00:00:00' AS DATETIME)
 AND COALESCE(t_u_business_region.u_code, FIRST_GROUP.region_code) = 'GB'
 AND COALESCE(t_u_division.u_name, FIRST_GROUP.divison_name) = 'Lidl';