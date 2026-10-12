/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_metric_by_cashier_hour_1
   generated from Powerdesigner on Dienstag, 18. Februar 2025 17:40:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_app_fraud_detection.t_fraud_detection_metric_by_cashier_hour_1 (
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related cash register event happened.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
hr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The hour of the day of which the metrics are calculated'),
metric_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier of microstratey metric'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)'),
curr_cd STRING(3) OPTIONS(description='The currency code for the metric values'),
metric_val_1 BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The first value to calculate defined by microstrategy metric'),
metric_val_2 BIGNUMERIC(38,5) OPTIONS(description='The second value to calculate defined by microstrategy metric'),
metric_val_3 BIGNUMERIC(38,5) OPTIONS(description='The third value to calculate defined by microstrategy metric'),
metric_val_4 BIGNUMERIC(38,5) OPTIONS(description='The fourth value to calculate defined by microstrategy metric'),
PRIMARY KEY (store_sid, cashier_nr, bus_dt, metric_id, hr) NOT ENFORCED
)
OPTIONS(description='This table brings the values in a normalized form to calculate the metrics, which will be used for dynamic dashboard');