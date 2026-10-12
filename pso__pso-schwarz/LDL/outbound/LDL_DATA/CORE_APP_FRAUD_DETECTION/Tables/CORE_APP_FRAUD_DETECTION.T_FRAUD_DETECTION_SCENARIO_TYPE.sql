/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_scenario_type
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:14:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_app_fraud_detection.t_fraud_detection_scenario_type (
scenario_type_cd STRING(20) NOT NULL OPTIONS(description='The code of the scenario'),
scenario_type_descr STRING(250) NOT NULL OPTIONS(description='Describes a type of scenario Automaticly or manuall'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (scenario_type_cd) NOT ENFORCED
) OPTIONS(description='Describes a type of scenario. Automaticly or manuall');