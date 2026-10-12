CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_retail_event_line_scenario (retail_event_line_scenario_id
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event line.'), lang_cd
OPTIONS(description='The code identifying the language.'), retail_event_line_scenario_name
OPTIONS(description='The name of the business scenario which is represented by the retail event line.'),
retail_event_line_scenario_short_name
OPTIONS(description='The short name of the business scenario which is represented by the retail event line.'),
retail_event_line_scenario_descr
OPTIONS(description='A textual description of the conditions which determine the business scenario.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')) AS
SELECT *
FROM ldl_data_core_rel.t_retail_event_line_scenario AS MAIN
WHERE lang_cd = 'DE'
 AND retail_event_line_scenario_id NOT IN (SELECT ROUND(CAST(tech_cash_register_event_type_cd AS BIGNUMERIC), 0) AS
     tech_cash_register_event_type_cd
    FROM ldl_data_core_rel.t_technical_cash_register_event_type AS CRE
    WHERE lang_cd = 'DE'
    UNION ALL
    SELECT retail_event_scenario_id
    FROM ldl_data_core_rel.t_retail_event_scenario AS RES
    WHERE lang_cd = 'DE')
UNION ALL
SELECT ROUND(CAST(tech_cash_register_event_type_cd AS BIGNUMERIC), 0) AS tech_cash_register_event_type_cd,
 lang_cd,
 tech_cash_register_event_type_descr,
 tech_cash_register_event_type_descr AS tech_cash_register_event_type_descr0,
 tech_cash_register_event_type_descr AS tech_cash_register_event_type_descr1,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_core_rel.t_technical_cash_register_event_type AS MAIN
WHERE lang_cd = 'DE'
UNION ALL
SELECT retail_event_scenario_id,
 lang_cd,
 retail_event_scenario_name,
 retail_event_scenario_name AS retail_event_scenario_name0,
 retail_event_scenario_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_core_rel.t_retail_event_scenario AS MAIN
WHERE lang_cd = 'DE';