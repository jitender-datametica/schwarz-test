/* --------------------------------------------------------------------------------
   DDL for table: t_etl_parameter_value
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_ETL_PARAMETER_VALUE (
   load_id                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the execution of an ETL job.',
   pset_name                           VARCHAR(100)    NOT NULL COMMENT 'The name which uniquely identifies the parameter set.',
   param_name                          VARCHAR(100)    NOT NULL COMMENT 'The name which uniquely identifies the parameter.',
   param_txt                           VARCHAR(1000)   NOT NULL COMMENT 'The value which has been used for the given parameter.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_ETL_PARAMETER_VALUE PRIMARY KEY (load_id, pset_name, param_name) NOT ENFORCED
 )  COMMENT= 'When an ETL job is executed, its parameters get substituted. This entity tracks the parameter values which have been used for each run.';
