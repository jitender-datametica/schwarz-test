CREATE OR REPLACE VIEW META.V_SEC_MSTR_FIL_SYNC_STATUS_2(
	  SF_ROLE_USER_NAME
	, MSTR_PROJ_NR 
	, MSTR_SEC_FILTER_TEMPLATE_NAME 
	, LOG_MSTR_ENV_NAME 
	, LAST_LOGIC_UPDATE_TMSP 
	, LAST_VALUE_UPDATE_TMSP 
	, LAST_SEC_FILTER_UPDATE_TMSP 
	, LAST_SF_TO_MSTR_LINK_DWH_UPDATED_TMSP 
	, LAST_PROJECT_UPDATE_TMSP 
	, LAST_MSTR_UPDATE_TMSP 
	, LAST_CONFIG_UPDATE_TMSP 
	, SYNC_STATUS_CD 
	, LOG_MSTR_DATA_USER_GRP_NR 
	, LOG_MSTR_DATA_USER_GRP_NAME 
	, LOG_MSTR_SIAM_USER_GRP_NR 
	, LOG_MSTR_SIAM_USER_GRP_NAME 
	, LOG_MSTR_SECURITY_FILTER_NR 
	, LOG_MSTR_SECURITY_FILTER_NAME 
	, MSTR_OBJECT_SYNC_STATUS_CD
) AS
SELECT  pr.SF_ROLE_USER_NAME, predicate.MSTR_PROJ_NR ,sfp.MSTR_SEC_FILTER_TEMPLATE_NAME, NVL(sec_log.MSTR_ENV_NAME,'') AS LOG_MSTR_ENV_NAME-- root_predicate_name as predicate_name
, MAX(last_update_tmsp) AS last_logic_update_tmsp, MAX(pr.CONF_TMSP) AS last_value_update_tmsp , MAX(sfp.CONF_TMSP) AS last_sec_filter_update_tmsp, MAX(sf_to_mstr.CONF_TMSP) AS last_sf_to_mstr_link_dwh_updated_tmsp , MAX(mp.conf_tmsp) AS last_project_update_tmsp 
, MIN(sec_log.log_tmsp) AS last_mstr_update_tmsp 
, GREATEST(last_logic_update_tmsp,last_value_update_tmsp,last_sec_filter_update_tmsp,last_sf_to_mstr_link_dwh_updated_tmsp,last_project_update_tmsp) AS last_config_update_tmsp 
, DECODE( last_config_update_tmsp >= NVL(last_mstr_update_tmsp,last_config_update_tmsp), TRUE,'NOK','OK') AS sync_status_cd 
, NVL(MIN(sec_log.mstr_data_user_grp_nr),'') AS log_mstr_data_user_grp_nr 
, NVL(MIN(sec_log.mstr_data_user_grp_name),'') AS log_mstr_data_user_grp_name 
, NVL(MIN(sec_log.mstr_siam_user_grp_nr),'') AS log_mstr_siam_user_grp_nr 
, NVL(MIN(sec_log.mstr_siam_user_grp_name),'') AS log_mstr_siam_user_grp_name 
, NVL(MIN(sec_log.mstr_security_filter_nr),'') AS log_mstr_security_filter_nr 
, NVL(MIN(sec_log.mstr_security_filter_name),'') AS log_mstr_security_filter_name 
, DECODE(NVL(MIN(sec_log.sync_status_cd),''),'','NEW','UPDATE') AS mstr_object_sync_status_cd
FROM
(
SELECT CONNECT_BY_ROOT MSTR_PREDICATE_NAME AS root_predicate_name,LEVEL, x.MSTR_PROJ_NR 
, SYS_CONNECT_BY_PATH(MSTR_PREDICATE_NAME, ' -> '), x.MSTR_PREDICATE_LEFT_CHILD_NAME, x.MSTR_PREDICATE_RIGHT_CHILD_NAME, x.MSTR_PREDICATE_NAME AS predicate_name_child 
, x.CONF_TMSP AS predicate_dwh_updated_tmsp, y.CONF_TMSP AS at_dwh_updated_tmsp
, GREATEST(predicate_dwh_updated_tmsp,NVL(at_dwh_updated_tmsp,predicate_dwh_updated_tmsp)) AS last_update_tmsp
  FROM META.T_SEC_CONF_MSTR_FILTER_PREDICATE_2 x
  LEFT JOIN META.T_SEC_CONF_MSTR_PROJECT_ATTRIBUTE_2 y
   ON x.MSTR_ATTR_UNIQUE_NR = y.MSTR_ATTR_UNIQUE_NR 
    --START WITH predicate_name = 'Sales_2 Manager Complex incl. Benchmark'
    CONNECT BY
      MSTR_PREDICATE_NAME = PRIOR MSTR_PREDICATE_LEFT_CHILD_NAME OR MSTR_PREDICATE_NAME = PRIOR MSTR_PREDICATE_RIGHT_CHILD_NAME
) predicate
INNER JOIN META.t_sec_cONf_mstr_project_2 mp
ON mp.MSTR_PROJ_NR = predicate.MSTR_PROJ_NR
INNER JOIN META.T_SEC_CONF_MSTR_SEC_FILTER_TEMPLATE_TO_PREDICATE_2 sfp
ON sfp.MSTR_PROJ_NR = predicate.MSTR_PROJ_NR
AND sfp.MSTR_PREDICATE_NAME = predicate.root_predicate_name 
INNER JOIN META.T_SEC_CONF_MSTR_SEC_FILTER_TEMPLATE_2 sf_to_mstr
ON sf_to_mstr.MSTR_PROJ_NR = sfp.MSTR_PROJ_NR
AND sf_to_mstr.MSTR_SEC_FILTER_TEMPLATE_NAME = sfp.MSTR_SEC_FILTER_TEMPLATE_NAME
INNER JOIN META.v_sec_rap_sf_role_user_2 sf_cONf
ON sf_cONf.role_LEVEL = sf_to_mstr.SF_ROLE_USER_LVL_CD
INNER JOIN META.v_sec_cONf_filter_predicate_params_2 pr
ON pr.predicate_param_name = predicate_param_name
AND pr.SF_ROLE_USER_NAME = sf_cONf.SF_ROLE_USER_NAME 
LEFT JOIN META.T_SEC_MSTR_FIL_SYNC_LOG_2 sec_log
ON sec_log.MSTR_PROJ_NR = predicate.MSTR_PROJ_NR
AND sec_log.SF_ROLE_USER_NAME = REPLACE(sf_cONf.SF_ROLE_USER_NAME,'"','') 
AND sec_log.MSTR_SEC_FILTER_TEMPLATE_NAME = sf_to_mstr.MSTR_SEC_FILTER_TEMPLATE_NAME
AND sec_log.SYNC_STATUS_CD = 'OK'
AND LOG_VALID_FG
GROUP BY  pr.SF_ROLE_USER_NAME,predicate.MSTR_PROJ_NR,sfp.mstr_sec_filter_template_name,LOG_MSTR_ENV_NAME ;