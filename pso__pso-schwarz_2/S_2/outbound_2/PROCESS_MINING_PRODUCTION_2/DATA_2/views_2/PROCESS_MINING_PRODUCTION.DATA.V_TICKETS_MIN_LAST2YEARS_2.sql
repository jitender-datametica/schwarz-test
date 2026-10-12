CREATE OR REPLACE VIEW process_mining_production_data.v_tickets_min_last2years_2 (sys_id, number, sys_class_name, u_caller
, location_2, u_region, u_division, u_resolved_by_group, cmdb_ci, u_first_assignment_group, u_close_code, business_service
, u_causative_ci, state, u_division_business_region, u_end_user_escalation, z_reopen_count, u_source, z_solved_at,
z_priority, u_master_incident, parent_incident, z_is_major, u_affected_cis, u_affected_divisions, sys_created_on,
u_wrong_ticket_assignment_count, u_ticket_description_incomplete_count, u_system_outage, u_system_outage_in_min,
u_count_should_have_been_solved_by_earlier_support_level, u_knowledge_is_missing) AS SELECT *
FROM process_mining_production_data.v_tickets_min_2
WHERE z_solved_at IS NULL
 OR z_solved_at >= CAST('2024-03-01 00:00:00' AS DATETIME);