CREATE OR REPLACE VIEW process_mining_production_data.v_cel_inc_prb_matching (incident_number, region_u_code,
division_u_name, problem_number) AS SELECT TICKET.number AS incident_number,
 COALESCE(t_u_business_region.u_code, FIRST_GROUP.region_code) AS region_u_code,
 COALESCE(t_u_division.u_name, FIRST_GROUP.divison_name) AS division_u_name,
 t_problem.number AS problem_number
FROM process_mining_production_etl.t_incident AS TICKET
 LEFT JOIN process_mining_production_etl.v_user_group AS ASSIGNED_GROUP ON TICKET.assignment_group = ASSIGNED_GROUP.sys_id
  
 LEFT JOIN process_mining_production_etl.ticket_mapping_source ON TICKET.u_source = ticket_mapping_source.raw_data_source
    AND 'incident' = ticket_mapping_source.sys_class_name
 LEFT JOIN process_mining_production_etl.ticket_mapping_close_code ON TICKET.u_close_code = ticket_mapping_close_code.raw_data_close_code
    AND 'incident' = ticket_mapping_close_code.sys_class_name
 LEFT JOIN process_mining_production_etl.ticket_mapping_state ON TICKET.state = CAST(ticket_mapping_state.raw_data_state AS FLOAT64)
    AND TICKET.sys_class_name = ticket_mapping_state.sys_class_name
 LEFT JOIN process_mining_production_etl.t_cmdb_ci AS CMDB ON TICKET.cmdb_ci = CMDB.sys_id
 LEFT JOIN process_mining_production_etl.t_cmn_location AS LOCATION ON TICKET.location = LOCATION.sys_id
 LEFT JOIN process_mining_production_etl.t_u_division ON TICKET.u_division = t_u_division.sys_id
 LEFT JOIN process_mining_production_etl.t_u_division_business_region ON TICKET.u_division_business_region =
  t_u_division_business_region.sys_id
 LEFT JOIN process_mining_production_etl.t_u_business_region ON TICKET.u_region = t_u_business_region.sys_id
 LEFT JOIN process_mining_production_etl.v_user_group AS FIRST_GROUP ON TICKET.u_first_assignment_group = FIRST_GROUP.sys_id
  
 LEFT JOIN process_mining_production_etl.t_problem ON TICKET.problem_id = t_problem.sys_id AND COALESCE(t_u_business_region
      .u_code, FIRST_GROUP.region_code) = 'GB' AND COALESCE(t_u_division.u_name, FIRST_GROUP.divison_name) = 'Lidl' AND
   FIRST_GROUP.name = 'ldl-gb-it-ext-topdesk';