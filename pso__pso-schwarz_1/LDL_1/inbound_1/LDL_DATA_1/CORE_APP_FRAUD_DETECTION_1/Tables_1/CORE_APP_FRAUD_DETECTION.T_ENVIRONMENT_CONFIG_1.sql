/* --------------------------------------------------------------------------------
   DDL for table: t_environment_config_1
   generated from Powerdesigner on Freitag, 25. April 2025 09:09:41
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_ENVIRONMENT_CONFIG_1 (
   param_name                          VARCHAR(100)    NOT NULL COMMENT 'Holds the parameter value, E.g. param_name warehouse size and param_val_txt would have a XL or M.',
   param_val_txt                       VARCHAR(1000)   NOT NULL COMMENT 'Holds the parameter value, E.g. XL for the parameter value for the param_name warehouse size.',
   comment_txt                         VARCHAR(1000)   COMMENT 'Detail description of the parameter.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_ENVIRONMENT_CONFIG PRIMARY KEY (param_name) NOT ENFORCED
)  COMMENT= 'Holds the ZKP Application parameter values.';
