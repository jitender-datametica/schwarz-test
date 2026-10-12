/* --------------------------------------------------------------------------------
   DDL for table: t_load_metric_type_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_LOAD_METRIC_TYPE_1 (
   load_metric_type_cd                 VARCHAR(20)     NOT NULL COMMENT 'The code identifying the type of metric which is collected during the execution of an ETL job.',
   load_metric_type_descr              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of metric which is collected during the execution of an ETL job.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_LOAD_METRIC_TYPE PRIMARY KEY (load_metric_type_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the kind of measure which is collected during the execution of an ETL job.';