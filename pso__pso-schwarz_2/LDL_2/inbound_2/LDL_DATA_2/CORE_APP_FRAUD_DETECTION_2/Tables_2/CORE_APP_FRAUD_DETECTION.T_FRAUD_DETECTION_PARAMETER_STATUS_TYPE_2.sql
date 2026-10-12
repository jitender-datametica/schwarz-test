/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_parameter_status_type_2
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:12:23
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_PARAMETER_STATUS_TYPE_2 (
   param_status_cd                     VARCHAR(20)     NOT NULL COMMENT 'The status_2 of a parameter value if it is approved, requested or denied.',
   param_status_descr                  VARCHAR(250)    NOT NULL COMMENT 'The short name of parameter value status.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_PARAMETER_STATUS_TYPE PRIMARY KEY (param_status_cd) NOT ENFORCED
 )  COMMENT= 'The entity definies the lifecycle of the fraud detection parameter.';
