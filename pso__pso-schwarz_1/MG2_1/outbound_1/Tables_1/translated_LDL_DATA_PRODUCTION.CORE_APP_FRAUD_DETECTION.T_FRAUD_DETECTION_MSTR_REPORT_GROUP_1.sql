CREATE OR REPLACE TABLE ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_report_group_1 (
report_grp_id INTEGER NOT NULL OPTIONS(description='The unique identifier of fraud detection report group.'),
report_grp_name STRING(100) NOT NULL OPTIONS(description='The name of the identified dynamic report group'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (report_grp_id) NOT ENFORCED
) OPTIONS(description='Holds the report groups for dynamic dashboarding like\""Cancel\"",\""Returns\""...');