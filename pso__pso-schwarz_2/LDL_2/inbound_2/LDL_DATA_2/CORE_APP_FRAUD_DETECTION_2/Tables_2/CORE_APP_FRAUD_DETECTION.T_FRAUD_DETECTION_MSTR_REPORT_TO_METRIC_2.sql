/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_mstr_report_to_metric_2
   generated from Powerdesigner on Montag, 14. Oktober 2024 12:38:40
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_MSTR_REPORT_TO_METRIC_2 (
   report_id                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of MicroStrategy Report',
   metric_id                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of microstratey metric',
   metric_offset                       NUMERIC(38,0)   NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_MSTR_REPORT_TO_METRIC PRIMARY KEY (report_id, metric_id) NOT ENFORCED
 )  COMMENT= 'Keeps the information which metrics will be presented on which report';