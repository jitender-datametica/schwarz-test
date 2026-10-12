/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_parameter_value
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:12:56
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_PARAMETER_VALUE (
   param_id                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of parameter (thereshold) of a scenario',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country is not identical to a political country',
   param_status_cd                     VARCHAR(20)     NOT NULL COMMENT 'The status of a parameter value if it is approved, requested or denied.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   param_val_qty                       NUMBER(38, 5)   COMMENT 'The value of scenario parameter, which is provided by end user.',
   requestor_user_name                 VARCHAR(100)    COMMENT 'The MSTR-User who enters the value to the system',
   request_tmsp                        TIMESTAMP_TZ(9) COMMENT 'The point of the time, when the entry is done.',
   approver_user_name                  VARCHAR(100)    COMMENT 'The MSTR-User who approves the value entered to the system',
   approved_tmsp                       TIMESTAMP_TZ(9) COMMENT 'The point of the time when the entry is approved.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_PARAMETER_VALUE PRIMARY KEY (param_id, country_org_cd, param_status_cd, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'A parameter can have a value which then impact the scenario result';
