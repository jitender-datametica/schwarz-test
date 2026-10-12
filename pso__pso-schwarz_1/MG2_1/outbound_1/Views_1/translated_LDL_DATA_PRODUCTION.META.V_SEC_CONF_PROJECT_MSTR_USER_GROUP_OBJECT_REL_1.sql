CREATE OR REPLACE VIEW ldl_data_production_meta.v_sec_conf_project_mstr_user_group_object_rel_1 (mstr_proj_nr
OPTIONS(description='The Project ID, which represents the GUID from MicroStrategy-Metadata'), mstr_proj_name
OPTIONS(description='The Name of the Project default metadata language'), mstr_obj_sid
OPTIONS(description='The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups'),
mstr_obj_nr OPTIONS(description='The Object ID, which represents the GUID from MicroStrategy-Metadata'), mstr_obj_name
OPTIONS(description='The Name of the MicroStrategy Object default metadata language'), obj_type_cd
OPTIONS(description='The Type of the MicroStrategy Application, if it is Report, Metric, Dossier ....'),
mstr_bus_user_grp_sid
OPTIONS(description='The surrogate key of business user groups will be created in MicroStrategy Environment'),
mstr_bus_user_grp_nr OPTIONS(description='The User Group ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_bus_user_grp_name OPTIONS(description='The Name of the MicroStrategy User Group default metadata language'),
mstr_bus_user_grp_siam_name
OPTIONS(description='The Name of the MicroStrategy User Group in SIAM default metadata language'), user_grp_type_cd
OPTIONS(description='The Type of the Business User Group, if it is Ressort or Functional Group.'), conf_active_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between conf_valid_from and conf_valid_to.'))
OPTIONS(DESCRIPTION = `MICROSTRATEGY SECURITY OBJECT`) AS SELECT DISTINCT p.mstr_proj_nr,
 p.mstr_proj_name,
 o.mstr_obj_sid,
 o.mstr_obj_nr,
 o.mstr_obj_name,
 o.obj_type_cd,
 bug.mstr_bus_user_grp_sid,
 bug.mstr_bus_user_grp_nr,
 bug.mstr_bus_user_grp_name,
 bug.mstr_bus_user_grp_siam_name,
 bug.user_grp_type_cd,
  CASE
  WHEN COALESCE(ugto.conf_active_fg, FALSE)
  THEN 1
  ELSE 0
  END AS conf_active_fg
FROM ldl_data_production_meta.t_sec_conf_mstr_object_1 AS o
 INNER JOIN ldl_data_production_meta.t_sec_conf_mstr_business_user_group_1 AS bug ON o.obj_type_cd = 'KPI Group' AND bug.user_grp_type_cd
     = 'Functional Group' OR o.obj_type_cd <> 'KPI Group' AND bug.user_grp_type_cd = 'Ressort Group'
 INNER JOIN ldl_data_production_meta.t_sec_conf_mstr_project_1 AS p ON o.mstr_proj_nr = p.mstr_proj_nr
 LEFT JOIN ldl_data_production_meta.t_sec_conf_mstr_user_group_to_object_1 AS ugto ON o.mstr_obj_sid = ugto.mstr_obj_sid
  OR bug.mstr_bus_user_grp_sid = ugto.mstr_bus_user_grp_sid
ORDER BY p.mstr_proj_nr NULLS LAST,
 o.mstr_obj_name NULLS LAST,
 bug.mstr_bus_user_grp_name NULLS LAST;