CREATE OR REPLACE VIEW process_mining_production_data.v_tickets (u_task_number, u_task_sys_class_name,
u_task_u_region_u_code, u_task_u_division_u_name, u_division_business_region, u_task_u_division_business_region_u_label
, u_task_u_resolved_by_group_name, u_task_u_resolved_by_group_u_division_u_name,
u_task_u_resolved_by_group_u_region_u_code, u_task_u_resolved_by_group_manager_department_name,
u_task_u_first_assignment_group_name, u_task_u_first_assignment_group_u_division_u_name,
u_task_u_first_assignment_group_u_region_u_code, u_task_u_first_assignment_group_manager_department_name,
u_task_cmdb_ci_name, u_task_cmdb_ci_u_id, z_close_code, u_task_business_service, u_task_u_causative_ci_name,
u_task_state, z_state, u_task_u_end_user_escalation, z_reopen_count, z_source, z_solved_at, z_priority,
u_task_ref_incident_u_master_incident, u_task_ref_incident_parent_incident_number, z_is_major, u_affected_cis,
u_affected_divisions, u_task_location_name, u_task_location_u_code, u_task_location_u_number, u_task_location_u_type,
u_task_location_u_warehouse_number, u_task_u_caller_location_u_code, u_task_u_caller_u_unit_department,
u_task_u_caller_u_region_u_code, u_task_u_caller_department_name, u_task_u_caller_company_name,
u_task_u_caller_u_division_u_name, sys_created_on, u_task_sys_id, u_task_u_wrong_ticket_assignment_count,
u_task_u_ticket_description_incomplete_count, u_task_u_system_outage, u_task_u_system_outage_in_min,
u_task_u_count_should_have_been_solved_by_earlier_support_level, u_task_u_knowledge_is_missing,
sla_business_duration_seconds, sla_business_pause_duration_seconds, sla_business_percentage,
sla_business_time_left_seconds, sla_duration_seconds, sla_has_breached, sla_pause_duration_seconds, sla_stage,
sla_contract_sla_name, sla_planned_end_time) AS SELECT TICKET.number AS u_task_number,
 TICKET.sys_class_name AS u_task_sys_class_name,
 COALESCE(t_u_business_region.u_code, FIRST_GROUP.region_code) AS u_task_u_region_u_code,
 COALESCE(t_u_division.u_name, FIRST_GROUP.divison_name) AS u_task_u_division_u_name,
 TICKET.u_division_business_region,
 t_u_division_business_region.u_label AS u_task_u_division_business_region_u_label,
 RESOLVED_GROUP.name AS u_task_u_resolved_by_group_name,
 RESOLVED_GROUP.divison_name AS u_task_u_resolved_by_group_u_division_u_name,
 RESOLVED_GROUP.region_code AS u_task_u_resolved_by_group_u_region_u_code,
 RESOLVED_GROUP.manager_department AS u_task_u_resolved_by_group_manager_department_name,
 FIRST_GROUP.name AS u_task_u_first_assignment_group_name,
 FIRST_GROUP.divison_name AS u_task_u_first_assignment_group_u_division_u_name,
 FIRST_GROUP.region_code AS u_task_u_first_assignment_group_u_region_u_code,
 FIRST_GROUP.manager_department AS u_task_u_first_assignment_group_manager_department_name,
 CMDB.name AS u_task_cmdb_ci_name,
 CMDB.u_id AS u_task_cmdb_ci_u_id,
 ticket_mapping_close_code.matching AS z_close_code,
 TICKET.business_service AS u_task_business_service,
 CAUSATIVE_CI.name AS u_task_u_causative_ci_name,
 ticket_mapping_state.matching AS u_task_state,
  CASE
  WHEN ticket_mapping_state.matching IN ('Analysis', 'Known Error', 'New', 'Open', 'Prepare Solution / Change',
    'Wait for enduser', 'Wait for external', 'Wait for problem', 'Work in progress')
  THEN 'Open'
  ELSE 'Solved'
  END AS z_state,
 TICKET.u_end_user_escalation AS u_task_u_end_user_escalation,
 TICKET.z_reopen_count,
 ticket_mapping_source.matching AS z_source,
 COALESCE(cast(TICKET.z_solved_at as timestamp), DATETIME_ADD(DATE_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL 8 HOUR)) AS z_solved_at,
 ticket_mapping_priority.matching AS z_priority,
 TICKET.u_master_incident AS u_task_ref_incident_u_master_incident,
 PARENT_INC.number AS u_task_ref_incident_parent_incident_number,
 TICKET.z_is_major,
 TICKET.u_affected_cis,
 TICKET.u_affected_divisions,
 LOCATION.name AS u_task_location_name,
 LOCATION.u_code AS u_task_location_u_code,
 LOCATION.u_number AS u_task_location_u_number,
 LOCATION.u_type AS u_task_location_u_type,
 LOCATION.u_warehouse_number AS u_task_location_u_warehouse_number,
 CALLER.location_u_code AS u_task_u_caller_location_u_code,
 CALLER.u_unit_department AS u_task_u_caller_u_unit_department,
 CALLER.region_code AS u_task_u_caller_u_region_u_code,
 CALLER.department_name AS u_task_u_caller_department_name,
 CALLER.company_name AS u_task_u_caller_company_name,
 CALLER.division_name AS u_task_u_caller_u_division_u_name,
 TICKET.sys_created_on,
 TICKET.sys_id AS u_task_sys_id,
 TICKET.u_wrong_ticket_assignment_count AS u_task_u_wrong_ticket_assignment_count,
 TICKET.u_ticket_description_incomplete_count AS u_task_u_ticket_description_incomplete_count,
 TICKET.u_system_outage AS u_task_u_system_outage,
 TICKET.u_system_outage_in_min AS u_task_u_system_outage_in_min,
 TICKET.u_count_should_have_been_solved_by_earlier_support_level AS
 u_task_u_count_should_have_been_solved_by_earlier_support_level,
 TICKET.u_knowledge_is_missing AS u_task_u_knowledge_is_missing,
 v_task_resolution_sla.sla_business_duration_seconds,
 v_task_resolution_sla.sla_business_pause_duration_seconds,
 v_task_resolution_sla.business_percentage AS sla_business_percentage,
 v_task_resolution_sla.sla_business_time_left_seconds,
 v_task_resolution_sla.sla_duration_seconds,
 v_task_resolution_sla.has_breached AS sla_has_breached,
 v_task_resolution_sla.sla_pause_duration_seconds,
 v_task_resolution_sla.stage AS sla_stage,
 v_task_resolution_sla.sla_contract_sla_name,
 v_task_resolution_sla.sla_planned_end_time
FROM process_mining_production_data.v_tickets_min AS TICKET
 LEFT JOIN process_mining_production_etl.t_cmn_location AS LOCATION ON TICKET.location = LOCATION.sys_id
 LEFT JOIN process_mining_production_etl.v_user AS CALLER ON TICKET.u_caller = CALLER.sys_id
 LEFT JOIN process_mining_production_etl.t_u_business_region ON TICKET.u_region = t_u_business_region.sys_id
 LEFT JOIN process_mining_production_etl.t_cmdb_ci AS CMDB ON TICKET.cmdb_ci = CMDB.sys_id
 LEFT JOIN process_mining_production_etl.t_cmdb_ci AS CAUSATIVE_CI ON TICKET.u_causative_ci = CAUSATIVE_CI.sys_id
 LEFT JOIN process_mining_production_etl.t_incident AS PARENT_INC ON TICKET.parent_incident = PARENT_INC.sys_id
 LEFT JOIN process_mining_production_etl.v_user_group AS RESOLVED_GROUP ON TICKET.u_resolved_by_group = RESOLVED_GROUP.sys_id
  
 LEFT JOIN process_mining_production_etl.v_user_group AS FIRST_GROUP ON TICKET.u_first_assignment_group = FIRST_GROUP.sys_id
  
 LEFT JOIN process_mining_production_etl.t_u_division ON TICKET.u_division = t_u_division.sys_id
 LEFT JOIN process_mining_production_etl.t_u_division_business_region ON TICKET.u_division_business_region =
  t_u_division_business_region.sys_id
 LEFT JOIN process_mining_production_etl.ticket_mapping_state ON TICKET.state = CAST(ticket_mapping_state.raw_data_state AS FLOAT64)
    AND TICKET.sys_class_name = ticket_mapping_state.sys_class_name
 LEFT JOIN process_mining_production_etl.ticket_mapping_priority ON TICKET.z_priority = CAST(ticket_mapping_priority.raw_data_priority AS FLOAT64)
    AND TICKET.sys_class_name = ticket_mapping_priority.sys_class_name
 LEFT JOIN process_mining_production_etl.ticket_mapping_close_code ON TICKET.u_close_code = ticket_mapping_close_code.raw_data_close_code
    AND TICKET.sys_class_name = ticket_mapping_close_code.sys_class_name
 LEFT JOIN process_mining_production_etl.ticket_mapping_source ON TICKET.u_source = ticket_mapping_source.raw_data_source
    AND TICKET.sys_class_name = ticket_mapping_source.sys_class_name
 LEFT JOIN process_mining_production_data.v_task_resolution_sla ON TICKET.sys_id = v_task_resolution_sla.task
WHERE ticket_mapping_state.matching NOT IN ('Closed', 'Closed Not Resolved', 'Closed Resolved', 'Completed', 'Resolved'
   )
 OR TICKET.z_solved_at IS NOT NULL;