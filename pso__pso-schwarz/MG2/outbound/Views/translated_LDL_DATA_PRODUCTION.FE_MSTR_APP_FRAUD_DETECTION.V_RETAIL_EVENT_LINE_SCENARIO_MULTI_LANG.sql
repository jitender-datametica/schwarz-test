CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_retail_event_line_scenario_multi_lang AS WITH
 allscenarioids AS ((SELECT retail_event_line_scenario_id
    FROM ldl_data_production_core_rel.t_retail_event_line_scenario
    UNION DISTINCT
    SELECT ROUND(CAST(tech_cash_register_event_type_cd AS BIGNUMERIC), 0) AS tech_cash_register_event_type_cd
    FROM ldl_data_production_core_rel.t_technical_cash_register_event_type)
   UNION DISTINCT
   SELECT retail_event_scenario_id
   FROM ldl_data_production_core_rel.t_retail_event_scenario), targetcountries AS (SELECT int_org_sid,
   official_lang_cd
  FROM ldl_data_production_core_dim.t_dim_internal_organization
  WHERE is_country_org_fg
   AND dwh_valid_fg), alltranslations AS (SELECT scenario_id,
   lang_cd,
   scenario_name,
   scenario_short_name,
   scenario_descr,
   dwh_created_tmsp,
   dwh_updated_tmsp,
   dwh_load_id,
   dwh_node_cd
  FROM (SELECT retail_event_line_scenario_id AS scenario_id,
      lang_cd,
      retail_event_line_scenario_name AS scenario_name,
      retail_event_line_scenario_short_name AS scenario_short_name,
      retail_event_line_scenario_descr AS scenario_descr,
      dwh_created_tmsp,
      dwh_updated_tmsp,
      dwh_load_id,
      dwh_node_cd,
      1 AS source_priority
     FROM ldl_data_production_core_rel.t_retail_event_line_scenario
     UNION ALL
     SELECT ROUND(CAST(tech_cash_register_event_type_cd AS BIGNUMERIC), 0) AS tech_cash_register_event_type_cd,
      lang_cd,
      tech_cash_register_event_type_descr,
      tech_cash_register_event_type_descr AS tech_cash_register_event_type_descr0,
      tech_cash_register_event_type_descr AS tech_cash_register_event_type_descr1,
      dwh_created_tmsp,
      dwh_updated_tmsp,
      dwh_load_id,
      dwh_node_cd,
      2 AS source_priority
     FROM ldl_data_production_core_rel.t_technical_cash_register_event_type
     UNION ALL
     SELECT retail_event_scenario_id,
      lang_cd,
      retail_event_scenario_name,
      retail_event_scenario_name AS retail_event_scenario_name0,
      retail_event_scenario_descr,
      dwh_created_tmsp,
      dwh_updated_tmsp,
      dwh_load_id,
      dwh_node_cd,
      3 AS source_priority
     FROM ldl_data_production_core_rel.t_retail_event_scenario) AS ALL_SOURCES
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(scenario_id AS STRING), lang_cd ORDER BY source_priority IS NULL,
        source_priority)) = 1) (SELECT TC.int_org_sid,
   t3.retail_event_line_scenario_id,
   TC.official_lang_cd,
   COALESCE(SPECIFIC_LANG.scenario_name, DEFAULT_LANG.scenario_name) AS retail_event_line_scenario_name,
   COALESCE(SPECIFIC_LANG.scenario_short_name, DEFAULT_LANG.scenario_short_name) AS
   retail_event_line_scenario_short_name,
   COALESCE(SPECIFIC_LANG.scenario_descr, DEFAULT_LANG.scenario_descr) AS retail_event_line_scenario_descr,
   DEFAULT_LANG.dwh_created_tmsp,
   DEFAULT_LANG.dwh_updated_tmsp,
   DEFAULT_LANG.dwh_load_id,
   DEFAULT_LANG.dwh_node_cd
  FROM allscenarioids AS t3
   INNER JOIN targetcountries AS TC ON TRUE
   LEFT JOIN alltranslations AS SPECIFIC_LANG ON t3.retail_event_line_scenario_id = SPECIFIC_LANG.scenario_id AND TC.official_lang_cd
      = SPECIFIC_LANG.lang_cd
   LEFT JOIN alltranslations AS DEFAULT_LANG ON t3.retail_event_line_scenario_id = DEFAULT_LANG.scenario_id AND
     DEFAULT_LANG.lang_cd = 'DE');