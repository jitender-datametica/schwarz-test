CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_retail_event_scenario_multi_lang (country_org_sid
OPTIONS(description='The identifier for the organization country'), retail_event_scenario_id
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event.'), lang_cd
OPTIONS(description='The code identifying the language.'), retail_event_scenario_name
OPTIONS(description='The name of the business scenario which is represented by the retail event.'),
retail_event_scenario_descr
OPTIONS(description='A textual description of the conditions which determine the business scenario.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE BUSINESS SCENARIO WHICH THE RETAIL EVENT REPRESENTS, E.G. REGULAR SALES, CANCELLED SALES, DEPOSIT RETURN, ETC. THE SCENARIO IS CALCULATED FROM A NUMBER OF OTHER ATTRIBUTES, SO IT IS DERIVED INFORMATION.`)
AS SELECT O.int_org_sid AS country_org_sid,
 MAIN.retail_event_scenario_id,
 MAIN.lang_cd,
 MAIN.retail_event_scenario_name,
 MAIN.retail_event_scenario_descr,
 MAIN.dwh_created_tmsp,
 MAIN.dwh_updated_tmsp,
 MAIN.dwh_load_id,
 MAIN.dwh_node_cd
FROM ldl_data_core_rel.t_retail_event_scenario AS MAIN
 INNER JOIN ldl_data_core_dim.t_dim_internal_organization AS O ON MAIN.lang_cd = O.official_lang_cd
WHERE O.is_country_org_fg
 AND O.dwh_valid_fg;