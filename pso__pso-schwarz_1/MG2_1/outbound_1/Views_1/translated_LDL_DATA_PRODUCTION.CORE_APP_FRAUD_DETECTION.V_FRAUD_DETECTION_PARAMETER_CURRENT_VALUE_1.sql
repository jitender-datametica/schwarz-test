CREATE OR REPLACE VIEW ldl_data_production_core_app_fraud_detection.v_fraud_detection_parameter_current_value_1 (param_id
, scenario_id, scenario_type_cd, param_name, country_org_cd, param_default_val_qty, param_country_val_qty, param_val_qty
, param_last_update_tmsp, is_scenario_enabled_in_country_fg) AS SELECT p.param_id,
 s.scenario_id,
 s.scenario_type_cd,
 p.param_name,
 ctr.country_org_cd,
 p.param_default_val_qty,
 pv.param_val_qty AS param_country_val_qty,
 IFNULL(pv.param_val_qty, p.param_default_val_qty) AS param_val_qty,
  (SELECT MAX(t)
  FROM UNNEST(ARRAY[p.dwh_updated_tmsp, pv.dwh_updated_tmsp]) AS t) AS param_last_update_tmsp,
  CASE
  WHEN p.scenario_id IS NULL
  THEN TRUE
  WHEN (COUNT(*) OVER (PARTITION BY CAST(p.scenario_id AS STRING), ctr.country_org_cd RANGE BETWEEN UNBOUNDED PRECEDING
     AND UNBOUNDED FOLLOWING)) = (COUNT(pv.param_val_qty) OVER (PARTITION BY CAST(p.scenario_id AS STRING), ctr.country_org_cd
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
  THEN TRUE
  ELSE FALSE
  END AS is_scenario_enabled_in_country_fg
FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_scenario_1 AS s
 INNER JOIN ldl_data_production_core_rel.t_internal_organization_1 AS ctr ON TRUE
 LEFT JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_parameter_1 AS p ON s.scenario_id = p.scenario_id
  
 LEFT JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_parameter_value_1 AS pv ON ctr.country_org_cd =
     pv.country_org_cd AND p.param_id = pv.param_id AND pv.param_status_cd = 'AP' AND pv.dwh_valid_fg
WHERE ctr.is_country_org_fg
 AND ctr.dwh_valid_fg;