CREATE OR REPLACE VIEW biaid_tools_projects_production_fe_mstr_costmonitor.v_iam_agg_azure_inv_systemgroup_hist_1 (container_name
, dwh_valid_from, project_id, project_short_name, solution_id, solution_name, storage_account, system_group, storage_gb
, is_last_per_month) AS SELECT container_name,
 dwh_valid_from,
 project_id,
 project_short_name,
 solution_id,
 solution_name,
 storage_account,
 system_group,
 storage_gb,
   (ROW_NUMBER() OVER (PARTITION BY container_name, project_id, solution_id, storage_account, system_group, DATE_TRUNC(dwh_valid_from
       , MONTH) ORDER BY dwh_valid_from IS NULL DESC, dwh_valid_from DESC)) = 1 AS is_last_per_month
FROM biaid_tools_projects_production_data.t_iam_agg_azure_inv_systemgroup_hist_1
WHERE dwh_valid_from >= DATE '2022-01-01';