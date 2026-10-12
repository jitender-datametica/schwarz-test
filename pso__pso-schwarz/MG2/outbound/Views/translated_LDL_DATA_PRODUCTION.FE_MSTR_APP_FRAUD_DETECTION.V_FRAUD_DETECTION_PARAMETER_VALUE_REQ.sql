CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_fraud_detection_parameter_value_req (country_org_sid
OPTIONS(description='THE CODE OF THE RELATED BUSINESS COUNTRY. (THE BUSINESS COUNTRY IS NOT IDENTICAL TO A POLITICAL COUNTRY'),
scenario_id OPTIONS(description='THE IDENTIFIER OF THE SCENARIO FOR FRAUD DETECTION'), param_id
OPTIONS(description='THE UNIQUE IDENTIFIER OF PARAMETER (THERESHOLD) OF A SCENARIO'), param_status_cd
OPTIONS(description='THE STATUS OF A PARAMETER VALUE IF IT IS APPROVED, REQUESTED OR DENIED.'), param_val_qty
OPTIONS(description='CURRENT VALUE OF A PARAMETER'), param_approved_val_qty
OPTIONS(description='APPROVED PARAMATER VALUE'), param_default_val_qty OPTIONS(description='DEFAULT PARAMETER VALUE'))
OPTIONS(DESCRIPTION = `THE UPDATED VALUE PARAMETERS WHICH ARE READY TO APPROVE`) AS SELECT org.int_org_sid AS
 country_org_sid,
 fdp.scenario_id,
 fdp.param_id,
  CASE
  WHEN fdpv.param_status_cd = 'RE'
  THEN 'RE'
  ELSE 'RE'
  END AS param_status_cd_req,
 MAX(CASE
   WHEN fdpv.param_status_cd = 'RE'
   THEN fdpv.param_val_qty
   ELSE NULL
   END) AS param_val_qty,
 MAX(CASE
   WHEN fdpv.param_status_cd = 'AP'
   THEN fdpv.param_val_qty
   ELSE NULL
   END) AS param_approved_val_qty,
 MAX(fdp.param_default_val_qty) AS param_default_val_qty
FROM ldl_data_production_core_dim.t_dim_internal_organization AS org
 INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario AS fds ON TRUE
 INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_parameter AS fdp ON fds.scenario_id = fdp.scenario_id
     AND org.dwh_valid_fg AND org.is_country_org_fg
 LEFT JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_parameter_value AS fdpv ON fdp.param_id = fdpv
     .param_id AND org.country_org_cd = fdpv.country_org_cd AND fdpv.dwh_valid_fg AND fdpv.param_status_cd IN ('RE',
    'AP')
GROUP BY country_org_sid,
 fdp.scenario_id,
 fdp.param_id,
 param_status_cd_req;