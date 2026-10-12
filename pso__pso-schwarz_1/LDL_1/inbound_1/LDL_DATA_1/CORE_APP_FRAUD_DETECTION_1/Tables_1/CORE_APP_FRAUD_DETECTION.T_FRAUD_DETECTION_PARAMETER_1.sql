/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_parameter_1
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:11:43
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_PARAMETER_1 (
   scenario_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of fraud detection scenario.',
   param_id                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of parameter (thereshold) of a scenario',
   param_name                          VARCHAR(100)    NOT NULL COMMENT 'The name of a scenario parameter',
   param_descr                         VARCHAR(250)    NOT NULL COMMENT 'The description of scenario paramter.',
   param_default_val_qty               NUMBER(38, 5)   COMMENT 'The default value of a scenario parameter.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_PARAMETER PRIMARY KEY (param_id) NOT ENFORCED
 )  COMMENT= 'One scenario defines one or several parameters.Several scenarios can use parameters with the same name.';
