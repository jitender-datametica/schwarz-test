CREATE OR REPLACE TABLE ldl_data_production_core_app_fraud_detection.t_cash_register_event_scenario_to_relationship_type_2
(
scenario_id INTEGER NOT NULL OPTIONS(description='The unique identifier of fraud detection scenario'),
cash_register_event_rel_type_cd STRING(20) NOT NULL
OPTIONS(description='The way one cash register event is related to another, return to sales_2 receipt (Geldrügabe zu Originalbon) '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cash_register_event_rel_type_cd, scenario_id) NOT ENFORCED
) OPTIONS(description='Keeps the information which scenario has which relationship type');