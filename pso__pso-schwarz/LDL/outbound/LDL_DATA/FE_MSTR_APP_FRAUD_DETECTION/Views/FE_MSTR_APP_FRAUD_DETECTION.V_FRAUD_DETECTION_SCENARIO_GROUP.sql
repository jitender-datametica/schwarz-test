CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_scenario_group (scenario_grp_id
OPTIONS(description='The unique identifier of fraud detection scenario group.'), scenario_grp_name
OPTIONS(description='The name of the identified scenario use case.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `HOLDS THE SCENARIO GROUPS (FOR EXAMPLE CANCEL, RETURNS..)`) AS SELECT *
FROM ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_group AS MAIN;