CREATE OR REPLACE VIEW biaid_tools_projects_production_fe_mstr_costmonitor.v_iam_cc_log (load_timestamp, environment,
content_date, status) AS SELECT *
FROM biaid_tools_projects_production_etl_process.t_iam_cc_log;