CREATE OR REPLACE VIEW ldl_data_meta.v_sec_mstr_fil_sync_status_1 (
    sf_role_user_name,
    mstr_proj_nr,
    mstr_sec_filter_template_name,
    log_mstr_env_name,
    last_logic_update_tmsp,
    last_value_update_tmsp,
    last_sec_filter_update_tmsp,
    last_sf_to_mstr_link_dwh_updated_tmsp,
    last_project_update_tmsp,
    last_mstr_update_tmsp,
    last_config_update_tmsp,
    sync_status_cd,
    log_mstr_data_user_grp_nr,
    log_mstr_data_user_grp_name,
    log_mstr_siam_user_grp_nr,
    log_mstr_siam_user_grp_name,
    log_mstr_security_filter_nr,
    log_mstr_security_filter_name,
    mstr_object_sync_status_cd
) AS


WITH RECURSIVE predicate_cte AS (
  
  SELECT 
    x.mstr_predicate_name AS root_predicate_name,
    1 AS level,
    x.mstr_proj_nr,
    CAST(x.mstr_predicate_name AS STRING) AS path_string, 
    x.mstr_predicate_left_child_name,
    x.mstr_predicate_right_child_name,
    x.mstr_predicate_name AS predicate_name_child,
    x.conf_tmsp AS predicate_dwh_updated_tmsp,
    y.conf_tmsp AS at_dwh_updated_tmsp,
    GREATEST(x.conf_tmsp, IFNULL(y.conf_tmsp, x.conf_tmsp)) AS last_update_tmsp,
    x.predicate_param_name 
  FROM ldl_data_meta.t_sec_conf_mstr_filter_predicate_1 x
  LEFT JOIN ldl_data_meta.t_sec_conf_mstr_project_attribute_1 y
    ON x.mstr_attr_unique_nr = y.mstr_attr_unique_nr
    
  UNION ALL
  
  
  SELECT 
    h.root_predicate_name,
    h.level + 1 AS level,
    x.mstr_proj_nr,
    CONCAT(h.path_string, ' -> ', x.mstr_predicate_name) AS path_string,
    x.mstr_predicate_left_child_name,
    x.mstr_predicate_right_child_name,
    x.mstr_predicate_name AS predicate_name_child,
    x.conf_tmsp AS predicate_dwh_updated_tmsp,
    y.conf_tmsp AS at_dwh_updated_tmsp,
    GREATEST(x.conf_tmsp, IFNULL(y.conf_tmsp, x.conf_tmsp)) AS last_update_tmsp,
    x.predicate_param_name
  FROM ldl_data_meta.t_sec_conf_mstr_filter_predicate_1 x
  LEFT JOIN ldl_data_meta.t_sec_conf_mstr_project_attribute_1 y
    ON x.mstr_attr_unique_nr = y.mstr_attr_unique_nr
  INNER JOIN predicate_cte h
    ON x.mstr_predicate_name = h.mstr_predicate_left_child_name 
    OR x.mstr_predicate_name = h.mstr_predicate_right_child_name
),


aggregated_data AS (
  SELECT  
    pr.sf_role_user_name, 
    predicate.mstr_proj_nr, 
    sfp.mstr_sec_filter_template_name, 
    IFNULL(sec_log.mstr_env_name, '') AS log_mstr_env_name,
    MAX(predicate.last_update_tmsp) AS last_logic_update_tmsp, 
    MAX(pr.conf_tmsp) AS last_value_update_tmsp, 
    MAX(sfp.conf_tmsp) AS last_sec_filter_update_tmsp, 
    MAX(sf_to_mstr.conf_tmsp) AS last_sf_to_mstr_link_dwh_updated_tmsp, 
    MAX(mp.conf_tmsp) AS last_project_update_tmsp, 
    MIN(sec_log.log_tmsp) AS last_mstr_update_tmsp, 
    IFNULL(MIN(sec_log.mstr_data_user_grp_nr), '') AS log_mstr_data_user_grp_nr, 
    IFNULL(MIN(sec_log.mstr_data_user_grp_name), '') AS log_mstr_data_user_grp_name, 
    IFNULL(MIN(sec_log.mstr_siam_user_grp_nr), '') AS log_mstr_siam_user_grp_nr, 
    IFNULL(MIN(sec_log.mstr_siam_user_grp_name), '') AS log_mstr_siam_user_grp_name, 
    IFNULL(MIN(sec_log.mstr_security_filter_nr), '') AS log_mstr_security_filter_nr, 
    IFNULL(MIN(sec_log.mstr_security_filter_name), '') AS log_mstr_security_filter_name,
    IFNULL(MIN(sec_log.sync_status_cd), '') AS min_sync_status_cd
  FROM predicate_cte predicate
  INNER JOIN ldl_data_meta.t_sec_conf_mstr_project_1 mp
    ON mp.mstr_proj_nr = predicate.mstr_proj_nr
  INNER JOIN ldl_data_meta.t_sec_conf_mstr_sec_filter_template_to_predicate_1 sfp
    ON sfp.mstr_proj_nr = predicate.mstr_proj_nr
    AND sfp.mstr_predicate_name = predicate.root_predicate_name 
  INNER JOIN ldl_data_meta.t_sec_conf_mstr_sec_filter_template_1 sf_to_mstr
    ON sf_to_mstr.mstr_proj_nr = sfp.mstr_proj_nr
    AND sf_to_mstr.mstr_sec_filter_template_name = sfp.mstr_sec_filter_template_name
  INNER JOIN ldl_data_meta.v_sec_rap_sf_role_user_1 sf_conf
    ON sf_conf.role_level = sf_to_mstr.sf_role_user_lvl_cd
  INNER JOIN ldl_data_meta.v_sec_conf_filter_predicate_params_1 pr
    ON pr.predicate_param_name = predicate.predicate_param_name 
    AND pr.sf_role_user_name = sf_conf.sf_role_user_name 
  LEFT JOIN ldl_data_meta.t_sec_mstr_fil_sync_log_1 sec_log
    ON sec_log.mstr_proj_nr = predicate.mstr_proj_nr
    AND sec_log.sf_role_user_name = REPLACE(sf_conf.sf_role_user_name, '"', '') 
    AND sec_log.mstr_sec_filter_template_name = sf_to_mstr.mstr_sec_filter_template_name
    AND sec_log.sync_status_cd = 'OK'
    AND sec_log.log_valid_fg = TRUE 
  GROUP BY 
    pr.sf_role_user_name,
    predicate.mstr_proj_nr,
    sfp.mstr_sec_filter_template_name,
    IFNULL(sec_log.mstr_env_name, '')
),


calculated_config AS (
  SELECT 
    *,
    GREATEST(
      last_logic_update_tmsp,
      CAST(last_value_update_tmsp AS TIMESTAMP),
      last_sec_filter_update_tmsp,
      last_sf_to_mstr_link_dwh_updated_tmsp,
      last_project_update_tmsp
    ) AS last_config_update_tmsp
  FROM aggregated_data
)


SELECT
  sf_role_user_name,
  mstr_proj_nr,
  mstr_sec_filter_template_name,
  log_mstr_env_name,
  last_logic_update_tmsp,
  last_value_update_tmsp,
  last_sec_filter_update_tmsp,
  last_sf_to_mstr_link_dwh_updated_tmsp,
  last_project_update_tmsp,
  last_mstr_update_tmsp,
  last_config_update_tmsp,
  CASE 
    WHEN last_config_update_tmsp >= IFNULL(last_mstr_update_tmsp, last_config_update_tmsp) THEN 'NOK'
    ELSE 'OK' 
  END AS sync_status_cd,
  log_mstr_data_user_grp_nr,
  log_mstr_data_user_grp_name,
  log_mstr_siam_user_grp_nr,
  log_mstr_siam_user_grp_name,
  log_mstr_security_filter_nr,
  log_mstr_security_filter_name,
  CASE 
    WHEN min_sync_status_cd = '' THEN 'NEW' 
    ELSE 'UPDATE' 
  END AS mstr_object_sync_status_cd
FROM calculated_config;