/* --------------------------------------------------------------------------------
   DDL for table: t_etl_application_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_ETL_APPLICATION_2 (
   etl_appl_sid                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the group of ETL jobs that form an application.',
   etl_appl_name                       VARCHAR(100)    NOT NULL COMMENT 'The name for the group of ETL jobs that form an application.',
   etl_appl_descr                      VARCHAR(250)    COMMENT 'A textual description of the ETL application, detailing the purpose and structure of the application.',
   sys_name                            VARCHAR(100)    NOT NULL COMMENT 'The name of the system on which the application runs.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_ETL_APPLICATION PRIMARY KEY (etl_appl_sid) NOT ENFORCED
 )  COMMENT= 'ETL jobs which serve the same purpose, e.g. which load the same set of target tables, form an application';