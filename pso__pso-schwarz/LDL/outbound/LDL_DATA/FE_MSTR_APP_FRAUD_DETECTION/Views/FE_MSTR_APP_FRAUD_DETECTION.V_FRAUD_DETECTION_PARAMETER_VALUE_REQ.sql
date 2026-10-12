CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_parameter_value_req (country_org_sid
OPTIONS(description='THE CODE OF THE RELATED BUSINESS COUNTRY. (THE BUSINESS COUNTRY IS NOT IDENTICAL TO A POLITICAL COUNTRY'),
scenario_id OPTIONS(description='THE IDENTIFIER OF THE SCENARIO FOR FRAUD DETECTION'), param_id
OPTIONS(description='THE UNIQUE IDENTIFIER OF PARAMETER (THERESHOLD) OF A SCENARIO'), param_status_cd
OPTIONS(description='THE STATUS OF A PARAMETER VALUE IF IT IS APPROVED, REQUESTED OR DENIED.'), param_val_qty
OPTIONS(description='CURRENT VALUE OF A PARAMETER'), param_approved_val_qty
OPTIONS(description='APPROVED PARAMATER VALUE'), param_default_val_qty OPTIONS(description='DEFAULT PARAMETER VALUE'))
OPTIONS(DESCRIPTION = `THE UPDATED VALUE PARAMETERS WHICH ARE READY TO APPROVE`) AS SELECT ORG.int_org_sid AS
 country_org_sid,
 FDP.scenario_id,
 FDP.param_id,
  CASE
  WHEN FDPV.param_status_cd = 'RE'
  THEN 'RE'
  ELSE 'RE'
  END AS param_status_cd_req,
 MAX(CASE
   WHEN FDPV.param_status_cd = 'RE'
   THEN FDPV.param_val_qty
   ELSE NULL
   END) AS param_val_qty,
 MAX(CASE
   WHEN FDPV.param_status_cd = 'AP'
   THEN FDPV.param_val_qty
   ELSE NULL
   END) AS param_approved_val_qty,
 MAX(FDP.param_default_val_qty) AS param_default_val_qty
FROM ldl_data_core_dim.t_dim_internal_organization AS ORG
 INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_scenario AS FDS ON TRUE
 INNER JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_parameter AS FDP ON FDS.scenario_id = FDP.scenario_id
   AND ORG.dwh_valid_fg AND ORG.is_country_org_fg
 LEFT JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_parameter_value AS FDPV ON FDP.param_id = FDPV.param_id
    AND ORG.country_org_cd = FDPV.country_org_cd AND FDPV.dwh_valid_fg AND FDPV.param_status_cd IN ('RE', 'AP')
GROUP BY country_org_sid,
 FDP.scenario_id,
 FDP.param_id,
 param_status_cd_req;