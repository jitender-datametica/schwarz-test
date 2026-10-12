CREATE OR REPLACE VIEW ldl_data_meta.v_sec_conf_project_mstr_user_group_object_rel (mstr_proj_nr
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
OPTIONS(DESCRIPTION = `A MICROSTRATEGY SECURITY OBJECT`) AS SELECT DISTINCT P.mstr_proj_nr,
 P.mstr_proj_name,
 O.mstr_obj_sid,
 O.mstr_obj_nr,
 O.mstr_obj_name,
 O.obj_type_cd,
 BUG.mstr_bus_user_grp_sid,
 BUG.mstr_bus_user_grp_nr,
 BUG.mstr_bus_user_grp_name,
 BUG.mstr_bus_user_grp_siam_name,
 BUG.user_grp_type_cd,
  CASE
  WHEN COALESCE(UGTO.conf_active_fg, FALSE)
  THEN 1
  ELSE 0
  END AS conf_active_fg
FROM ldl_data_meta.t_sec_conf_mstr_object AS O
 INNER JOIN ldl_data_meta.t_sec_conf_mstr_business_user_group AS BUG ON O.obj_type_cd = 'KPI Group' AND BUG.user_grp_type_cd
     = 'Functional Group' OR O.obj_type_cd <> 'KPI Group' AND BUG.user_grp_type_cd = 'Ressort Group'
 INNER JOIN ldl_data_meta.t_sec_conf_mstr_project AS P ON O.mstr_proj_nr = P.mstr_proj_nr
 LEFT JOIN ldl_data_meta.t_sec_conf_mstr_user_group_to_object AS UGTO ON O.mstr_obj_sid = UGTO.mstr_obj_sid OR BUG.mstr_bus_user_grp_sid
    = UGTO.mstr_bus_user_grp_sid
ORDER BY P.mstr_proj_nr NULLS LAST,
 O.mstr_obj_name NULLS LAST,
 BUG.mstr_bus_user_grp_name NULLS LAST;