CREATE OR REPLACE VIEW ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value_2 (param_id,
scenario_id, scenario_type_cd, param_name, country_org_cd, param_default_val_qty, param_country_val_qty, param_val_qty,
param_last_update_tmsp, is_scenario_enabled_in_country_fg) AS SELECT P.param_id,
 S.scenario_id,
 S.scenario_type_cd,
 P.param_name,
 CTR.country_org_cd,
 P.param_default_val_qty,
 PV.param_val_qty AS param_country_val_qty,
 IFNULL(PV.param_val_qty, P.param_default_val_qty) AS param_val_qty,
  (SELECT MAX(t)
  FROM UNNEST(ARRAY[P.DWH_UPDATED_TMSP, PV.DWH_UPDATED_TMSP]) AS t) AS param_last_update_tmsp,
  CASE
  WHEN P.scenario_id IS NULL
  THEN TRUE
  WHEN (COUNT(*) OVER (PARTITION BY CAST(P.scenario_id AS STRING), CTR.country_org_cd RANGE BETWEEN UNBOUNDED PRECEDING
     AND UNBOUNDED FOLLOWING)) = (COUNT(PV.param_val_qty) OVER (PARTITION BY CAST(P.scenario_id AS STRING), CTR.country_org_cd
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
  THEN TRUE
  ELSE FALSE
  END AS is_scenario_enabled_in_country_fg
FROM ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_2 AS S
 INNER JOIN ldl_data_core_rel.t_internal_organization_2 AS CTR ON TRUE
 LEFT JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_parameter_2 AS P ON S.scenario_id = P.scenario_id
 LEFT JOIN ldl_data_core_app_fraud_detection.t_fraud_detection_parameter_value_2 AS PV ON CTR.country_org_cd = PV.country_org_cd
      AND P.param_id = PV.param_id AND PV.param_status_cd = 'AP' AND PV.dwh_valid_fg
WHERE CTR.is_country_org_fg
 AND CTR.dwh_valid_fg;