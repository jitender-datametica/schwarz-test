CREATE OR REPLACE VIEW biaid_tools_projects_production_fe_mstr_costmonitor.v_iam_abinitio_ksh_usage_1 (alert_team_id,
application, collection_day, executable_enum, host, job_definition, ksh, solution_id, solution_name, system) AS SELECT
 alert_team_id,
 application,
 collection_day,
 executable_enum,
 host,
 job_definition,
 ksh,
 solution_id,
 solution_name,
 system
FROM biaid_tools_projects_production_data.t_iam_abinitio_ksh_usage_1;