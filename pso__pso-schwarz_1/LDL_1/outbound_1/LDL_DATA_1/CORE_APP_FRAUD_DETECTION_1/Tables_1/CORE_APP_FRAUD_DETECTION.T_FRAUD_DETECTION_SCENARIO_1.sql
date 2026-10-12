/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_scenario_1
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:13:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_1 (
scenario_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier of fraud detection scenario'),
scenario_type_cd STRING(20) NOT NULL
OPTIONS(description='Type of scenario, code which defines automatic and manuall type of scenario'),
scenario_name STRING(100) NOT NULL OPTIONS(description='The name of the identified scenario use case.'),
scenario_descr STRING(250) NOT NULL OPTIONS(description='Describes the scenario.'),
scenario_grp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of fraud detection scenario group.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (scenario_id) NOT ENFORCED
) OPTIONS(description='Keeps the fraud detection scenario and their relationship to groups.');