CREATE OR REPLACE VIEW META.V_SEC_CONF_PROJECT_MSTR_USER_GROUP_OBJECT_REL(
  MSTR_PROJ_NR COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata' 
, MSTR_PROJ_NAME COMMENT 'The Name of the Project default metadata language' 
, MSTR_OBJ_SID COMMENT 'The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups' 
, MSTR_OBJ_NR COMMENT 'The Object ID, which represents the GUID from MicroStrategy-Metadata' 
, MSTR_OBJ_NAME COMMENT 'The Name of the MicroStrategy Object default metadata language' 
, OBJ_TYPE_CD COMMENT 'The Type of the MicroStrategy Application, if it is Report, Metric, Dossier ....' 
, MSTR_BUS_USER_GRP_SID COMMENT 'The surrogate key of business user groups will be created in MicroStrategy Environment' 
, MSTR_BUS_USER_GRP_NR COMMENT 'The User Group ID, which represents the GUID from MicroStrategy-Metadata' 
, MSTR_BUS_USER_GRP_NAME COMMENT 'The Name of the MicroStrategy User Group default metadata language' 
, MSTR_BUS_USER_GRP_SIAM_NAME COMMENT 'The Name of the MicroStrategy User Group in SIAM default metadata language' 
, USER_GRP_TYPE_CD COMMENT 'The Type of the Business User Group, if it is Ressort or Functional Group.' 
, CONF_ACTIVE_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between conf_valid_from and conf_valid_to.'
) COMMENT='A Microstrategy Security Object'
 AS
SELECT DISTINCT
     p.mstr_proj_nr 
   , p.mstr_proj_name 
   , o.mstr_obj_sid 
   , o.mstr_obj_nr 
   , o.mstr_obj_name 
   , o.obj_type_cd 
   , bug.mstr_bus_user_grp_sid 
   , bug.mstr_bus_user_grp_nr 
   , bug.mstr_bus_user_grp_name 
   , bug.mstr_bus_user_grp_siam_name 
   , bug.user_grp_type_cd 
   , COALESCE(ugto.conf_active_fg, FALSE)::INT AS conf_active_fg
FROM META.T_SEC_CONF_MSTR_OBJECT o
CROSS JOIN META.T_SEC_CONF_MSTR_BUSINESS_USER_GROUP bug
JOIN META.T_SEC_CONF_MSTR_PROJECT p
    ON o.mstr_proj_nr = p.mstr_proj_nr
LEFT JOIN META.T_SEC_CONF_MSTR_USER_GROUP_TO_OBJECT ugto
    ON o.mstr_obj_sid = ugto.mstr_obj_sid
   AND bug.mstr_bus_user_grp_sid = ugto.mstr_bus_user_grp_sid
WHERE (
      (o.obj_type_cd = 'KPI Group' AND bug.user_grp_type_cd = 'Functional Group')
   OR (o.obj_type_cd <> 'KPI Group' AND bug.user_grp_type_cd = 'Ressort Group')
)
ORDER BY 
    p.mstr_proj_nr 
  ,  o.mstr_obj_name 
  ,  bug.mstr_bus_user_grp_name;