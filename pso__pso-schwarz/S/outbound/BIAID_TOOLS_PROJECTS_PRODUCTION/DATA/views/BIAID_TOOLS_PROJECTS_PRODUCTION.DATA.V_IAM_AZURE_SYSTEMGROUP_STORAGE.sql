CREATE OR REPLACE VIEW biaid_tools_projects_production_data.v_iam_azure_systemgroup_storage (project_id,
project_short_name, storage_account, container_name, system_group, storage_gb) AS SELECT APT.project_id,
 APT.project_short_name,
 ASM.storage_account,
 ASM.container_name,
 ASM.system_group,
 ROUND(SUM(ASM.content_length) / 1073741824, 2) AS storage_gb
FROM biaid_tools_projects_production_data.t_iam_azure_storage_management AS ASM
 LEFT JOIN biaid_tools_projects_production_data.t_iam_azure_folder_structure AS AFS ON ASM.storage_account = AFS.storage_account_name
     AND ASM.container_name = AFS.container_name AND ASM.system_group = AFS.system_group
 LEFT JOIN biaid_tools_projects_production_data.t_iam_azure_project_tracking AS APT ON AFS.project_id = APT.project_id
  AND AFS.storage_account_name LIKE CONCAT('%', APT.tenant, 'l', APT.secure_level, '%')
GROUP BY APT.project_id,
 APT.project_short_name,
 ASM.storage_account,
 ASM.container_name,
 ASM.system_group;