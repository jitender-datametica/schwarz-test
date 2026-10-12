/* --------------------------------------------------------------------------------
   DDL for table: t_etl_job_data_structure_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_ETL_JOB_DATA_STRUCTURE_2 (
   etl_job_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the ETL job',
   data_struct_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data structure.',
   data_obj_access_type_cd             VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way how a data object is used by an ETL job.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_ETL_JOB_DATA_STRUCTURE PRIMARY KEY (etl_job_sid, data_obj_access_type_cd, data_struct_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'An ETL job may use a data object in various different ways. It may read from the object, it may write it, it may reference it as a lookup or use it as an intermediate storage. This entity links an ETL job to all its referenced data objects. The way how the data object is used, is defined by the usage type.';
