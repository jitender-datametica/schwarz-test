/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_mstr_metric_2
   generated from Powerdesigner on Montag, 14. Oktober 2024 12:37:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_MSTR_METRIC_2 (
   metric_id                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of microstratey metric',
   scenario_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of fraud detection scenario',
   metric_name                         VARCHAR(100)    NOT NULL COMMENT 'The name of the microstrategy metric presented at frontend.',
   metric_descr                        VARCHAR(250)    NOT NULL COMMENT 'Describes the MicroStrategy Metric.',
   calculation_type_cd                 VARCHAR(20)     NOT NULL COMMENT 'Type of calculation, code which defines type of calculation like SUM, weighted Average, count',
   format_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'Type of format, code which defines metric format like integer, percent, currency',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_MSTR_METRIC PRIMARY KEY (metric_id) NOT ENFORCED
 )  COMMENT= 'Keeps the fraud detection metrics for MicroStrategy Dynamic Dashboards ';