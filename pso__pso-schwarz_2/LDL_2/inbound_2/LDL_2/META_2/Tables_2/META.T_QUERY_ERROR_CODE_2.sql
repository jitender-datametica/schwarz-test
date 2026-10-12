/* --------------------------------------------------------------------------------
   DDL for table: t_query_error_code_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_QUERY_ERROR_CODE_2 (
   query_error_cd                      VARCHAR(20)     NOT NULL COMMENT 'The error code, as defined by the database engine.',
   query_error_descr                   VARCHAR(250)    NOT NULL COMMENT 'The description for the error.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_QUERY_ERROR_CODE PRIMARY KEY (query_error_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the SQL error codes for a query. If a query was executed successfully, the error code is empty.';