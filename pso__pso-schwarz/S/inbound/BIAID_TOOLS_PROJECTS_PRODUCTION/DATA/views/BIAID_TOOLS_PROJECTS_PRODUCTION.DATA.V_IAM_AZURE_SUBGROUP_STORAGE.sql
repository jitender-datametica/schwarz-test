create or replace view BIAID_TOOLS_PROJECTS_PRODUCTION.DATA.V_IAM_AZURE_SUBGROUP_STORAGE(
	PROJECT_ID,
	PROJECT_SHORT_NAME,
	STORAGE_ACCOUNT,
	CONTAINER_NAME,
	SYSTEM_GROUP,
	SUB_GROUP,
	STORAGE_GB
) as
SELECT
  project_id
, project_short_name
, storage_account
, container_name
, system_group
, sub_group
, Storage_GB
FROM
(
SELECT apt.project_id
, apt.project_short_name
, asm.storage_account
, asm.container_name
, asm.system_group
, asm.sub_group
, round(SUM(asm.content_length)/1073741824,2) AS Storage_GB
FROM data.t_iam_azure_storage_management asm

LEFT OUTER JOIN data.t_iam_azure_folder_structure afs ON
asm.storage_account = afs.storage_account_name
AND asm.container_name = afs.container_name
AND asm.system_group = afs.system_group

LEFT OUTER JOIN data.t_iam_azure_project_tracking apt
ON afs.project_id = apt.project_id
AND afs.storage_account_name LIKE concat('%',apt.tenant,'l',apt.secure_level,'%')

GROUP BY
apt.project_id
, apt.project_short_name
, asm.storage_account
, asm.container_name
, asm.system_group
, asm.sub_group);