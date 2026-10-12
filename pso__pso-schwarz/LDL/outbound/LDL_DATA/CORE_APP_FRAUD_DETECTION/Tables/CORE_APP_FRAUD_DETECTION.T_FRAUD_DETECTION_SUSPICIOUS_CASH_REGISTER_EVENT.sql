/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_suspicious_cash_register_event
   generated from Powerdesigner on Montag, 14. Oktober 2024 13:00:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_app_fraud_detection.t_fraud_detection_suspicious_cash_register_event (
cash_register_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.'),
scenario_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier of fraud detection scenario'),
fraud_analysis_status_cd STRING(20) NOT NULL
OPTIONS(description='The are different status codes.First status code comes: SP-suspicious and then maybe later on NSP- not suspicious'),
comment_tnx STRING(1000) OPTIONS(description='Describes why the user was clasified the record ( true or  false)'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
marked_by_user_name STRING(100) OPTIONS(description='The MicroStrategy-User who marked the receipt'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cash_register_event_sid, scenario_id) NOT ENFORCED
) OPTIONS(description='From Business User marked receipts, which from his view of point are suspicious');