CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_retail_event_line_scenario_multi_lang_2 (country_org_sid
OPTIONS(description='THE IDENTIFIER FOR THE ORGANIZATION COUNTRY_2'), retail_event_line_scenario_id
OPTIONS(description='THE NUMERIC IDENTIFIER FOR THE SCENARIO WHICH IS REPRESENTED BY THE RETAIL EVENT LINE.'), lang_cd
OPTIONS(description='THE CODE IDENTIFYING THE LANGUAGE.'), retail_event_line_scenario_name
OPTIONS(description='THE NAME OF THE BUSINESS SCENARIO WHICH IS REPRESENTED BY THE RETAIL EVENT LINE.'),
retail_event_line_scenario_short_name
OPTIONS(description='THE NAME OF THE BUSINESS SCENARIO WHICH IS REPRESENTED BY THE RETAIL EVENT LINE.'),
retail_event_line_scenario_descr
OPTIONS(description='A TEXTUAL DESCRIPTION OF THE CONDITIONS WHICH DETERMINE THE BUSINESS SCENARIO.'), dwh_created_tmsp
OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS CREATED IN THE DATA WAREHOUSE.'), dwh_updated_tmsp
OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS CREATED OR LAST UPDATED.'), dwh_load_id
OPTIONS(description='THE UNIQUE IDENTIFIER OF THE BATCH LOAD WHICH HAS DONE THE LAST UPDATE TO THIS RECORD. (CLOSING A RECORD IN HISTORY WITHOUT UPDATING ANY PAYLOAD COLUMNS DOES NOT TRIGGER AN UPDATE OF THE DWH_LOAD_ID.)'),
dwh_node_cd
OPTIONS(description='THE CODE FOR THE SOURCE SYSTEM (OR SLICE OF SOURCE SYSTEM) FROM WHICH THIS RECORD WAS LOADED.')) AS
WITH ALLSCENARIOIDS AS ((SELECT retail_event_line_scenario_id
    FROM ldl_data_core_rel.t_retail_event_line_scenario_2
    UNION DISTINCT
    SELECT ROUND(CAST(tech_cash_register_event_type_cd AS BIGNUMERIC), 0) AS tech_cash_register_event_type_cd
    FROM ldl_data_core_rel.t_technical_cash_register_event_type_2)
   UNION DISTINCT
   SELECT retail_event_scenario_id
   FROM ldl_data_core_rel.t_retail_event_scenario_2), TARGETCOUNTRIES AS (SELECT int_org_sid,
   official_lang_cd
  FROM ldl_data_core_dim.t_dim_internal_organization_2
  WHERE is_country_org_fg
   AND dwh_valid_fg), ALLTRANSLATIONS AS (SELECT scenario_id,
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
     FROM ldl_data_core_rel.t_retail_event_line_scenario_2
     WHERE retail_event_line_scenario_id <> 480
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
     FROM ldl_data_core_rel.t_technical_cash_register_event_type_2
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
     FROM ldl_data_core_rel.t_retail_event_scenario_2) AS ALL_SOURCES
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(scenario_id AS STRING), lang_cd ORDER BY source_priority IS NULL,
        source_priority)) = 1) (SELECT TC.int_org_sid,
   S.retail_event_line_scenario_id,
   TC.official_lang_cd,
   COALESCE(SPECIFIC_LANG.scenario_name, DEFAULT_LANG.scenario_name) AS retail_event_line_scenario_name,
   COALESCE(SPECIFIC_LANG.scenario_short_name, DEFAULT_LANG.scenario_short_name) AS
   retail_event_line_scenario_short_name,
   COALESCE(SPECIFIC_LANG.scenario_descr, DEFAULT_LANG.scenario_descr) AS retail_event_line_scenario_descr,
   DEFAULT_LANG.dwh_created_tmsp,
   DEFAULT_LANG.dwh_updated_tmsp,
   DEFAULT_LANG.dwh_load_id,
   DEFAULT_LANG.dwh_node_cd
  FROM ALLSCENARIOIDS AS S
   INNER JOIN TARGETCOUNTRIES AS TC ON TRUE
   LEFT JOIN ALLTRANSLATIONS AS SPECIFIC_LANG ON S.retail_event_line_scenario_id = SPECIFIC_LANG.scenario_id AND TC.official_lang_cd
      = SPECIFIC_LANG.lang_cd
   LEFT JOIN ALLTRANSLATIONS AS DEFAULT_LANG ON S.retail_event_line_scenario_id = DEFAULT_LANG.scenario_id AND
     DEFAULT_LANG.lang_cd = 'DE');