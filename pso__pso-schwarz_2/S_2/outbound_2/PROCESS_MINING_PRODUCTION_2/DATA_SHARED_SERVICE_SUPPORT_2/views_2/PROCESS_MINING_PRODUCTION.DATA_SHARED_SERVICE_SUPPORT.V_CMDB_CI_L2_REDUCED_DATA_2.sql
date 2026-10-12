CREATE OR REPLACE VIEW process_mining_production_data_shared_service_support.v_cmdb_ci_l2_reduced_data_2 (asset,
business_unit, duplicate_of, model_id, cmdb_ot_entity, cost_center, department, u_department, location_2,
maintenance_schedule, schedule, company, manufacturer, vendor, life_cycle_stage, life_cycle_stage_status,
assignment_group, change_control, managed_by_group, support_group, u_calculation_level, u_division,
u_division_business_region, u_settlement_unit_key, asset_tag) AS SELECT *
FROM process_mining_production_eval.t_cmdb_ci_l2_reduced_2;