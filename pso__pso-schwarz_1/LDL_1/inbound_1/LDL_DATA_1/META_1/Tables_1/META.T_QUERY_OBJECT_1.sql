/* --------------------------------------------------------------------------------
   DDL for table: t_query_object_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_QUERY_OBJECT_1 (
   query_sid                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the query.',
   data_struct_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data structure which is accessed by the query.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_QUERY_OBJECT PRIMARY KEY (data_struct_sid, query_sid) NOT ENFORCED
 )  COMMENT= 'A query accesses several data structures.';