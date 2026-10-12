CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_scenario (scenario_id
OPTIONS(description='The unique identifier of fraud detection scenario'), scenario_type_cd
OPTIONS(description='Type of scenario, code which defines automatic and manuall type of scenario'), scenario_name
OPTIONS(description='The name of the identified scenario use case.'), scenario_descr
OPTIONS(description='Describes the scenario.'), scenario_grp_id
OPTIONS(description='The unique identifier of fraud detection scenario group.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `KEEPS THE FRAUD DETECTION SCENARIO AND THEIR RELATIONSHIP TO GROUPS.`) AS SELECT *
FROM ldl_data_core_app_fraud_detection.t_fraud_detection_scenario AS MAIN;