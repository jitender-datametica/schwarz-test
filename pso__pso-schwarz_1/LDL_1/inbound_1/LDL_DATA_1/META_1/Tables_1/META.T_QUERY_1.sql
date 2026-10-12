/* --------------------------------------------------------------------------------
   DDL for table: t_query_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_QUERY_1 (
   query_sid                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the query.',
   query_start_tmsp                    TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time, when the query was started.',
   query_end_tmsp                      TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time, when the query finished.',
   sql_txt                             VARCHAR(1000)   NOT NULL COMMENT 'The SQL statement.',
   user_name                           VARCHAR(100)    COMMENT 'The name of the user that submitted the query.',
   session_nr                          VARCHAR(20)     COMMENT 'The number which identifies a session on a system at a given point in time. (Session numbers may be re_1-used.)',
   role_name                           VARCHAR(100)    COMMENT 'The name of the role under which the query was executed.',
   snowflake_wh_name                   VARCHAR(100)    COMMENT 'The name for the compute resource on Snowflake which executes a query.',
   workload_class_cd                   VARCHAR(20)     COMMENT 'The code identifying the workload. E.g. customer segmentation queries, data mining, etc.',
   query_error_cd                      VARCHAR(20)     COMMENT 'The error code of the query, as defined by the database engine. If the query was executed successfully, the error code is empty.',
   query_error_txt                     VARCHAR(1000)   COMMENT 'The error message',
   returned_rec_cnt                    NUMBER(38, 0)   COMMENT 'The number of records which were returned to the user as the result of the query.',
   inserted_rec_cnt                    NUMBER(38, 0)   COMMENT 'The number of records which were inserted as the result of the query.',
   deleted_rec_cnt                     NUMBER(38, 0)   COMMENT 'The number of records which were deleted as the result of the query.',
   updated_rec_cnt                     NUMBER(38, 0)   COMMENT 'The number of records which were updated as the result of the query.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_QUERY PRIMARY KEY (query_sid) NOT ENFORCED
 )  COMMENT= 'A query is a piece of SQL (or a similar language) which is executed against a database management system.';