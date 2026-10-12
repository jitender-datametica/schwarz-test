/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_metric_by_cashier_hour
   generated from Powerdesigner on Dienstag, 18. Februar 2025 17:40:30
*/ --------------------------------------------------------------------------------
 
CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_METRIC_BY_CASHIER_HOUR (
   store_sid                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the related cash register event happened.',
   cashier_nr                          VARCHAR(20)     NOT NULL COMMENT 'The number which identifies the cashier. (The number is unique for a given store and a day.)',
   bus_dt                              DATE            NOT NULL COMMENT 'The business date on which the retail event is counted.',
   hr                                  NUMBER(38, 0)   NOT NULL COMMENT 'The hour of the day of which the metrics are calculated',
   metric_id                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of microstratey metric',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)',
   curr_cd                             VARCHAR(3)      COMMENT 'The currency code for the metric values',
   metric_val_1                        NUMBER(38, 5)   NOT NULL COMMENT 'The first value to calculate defined by microstrategy metric',
   metric_val_2                        NUMBER(38, 5)   COMMENT 'The second value to calculate defined by microstrategy metric',
   metric_val_3                        NUMBER(38, 5)   COMMENT 'The third value to calculate defined by microstrategy metric',
   metric_val_4                        NUMBER(38, 5)   COMMENT 'The fourth value to calculate defined by microstrategy metric',
   CONSTRAINT PK_T_FRAUD_DETECTION_METRIC_BY_CASHIER_HOUR PRIMARY KEY (store_sid, cashier_nr, bus_dt, metric_id, hr) NOT ENFORCED
)  COMMENT= 'This table brings the values in a normalized form to calculate the metrics, which will be used for dynamic dashboard';