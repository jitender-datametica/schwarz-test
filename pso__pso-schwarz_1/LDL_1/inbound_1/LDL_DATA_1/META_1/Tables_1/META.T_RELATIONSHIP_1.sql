/* --------------------------------------------------------------------------------
   DDL for table: t_relationship_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_RELATIONSHIP_1 (
   rel_sid                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the relationship',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   rel_name                            VARCHAR(100)    COMMENT 'The name for the relationship, as it has been defined in the data model',
   cardinality_cd                      VARCHAR(5)      NOT NULL COMMENT 'A code identifying the cardinality, i.e. 1:1, 1:n or n:m',
   data_struct_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the first data structure.',
   data_struct_nullable_fg             BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the (first) data object is optional, If it is false, then a relationship must exist for each instance of the first data object.',
   rel_data_struct_sid                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the second data structure.',
   rel_data_struct_nullable_fg         BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the related (second) data object is optional. If it is false, then a relationship must exist for each instance of the second data object.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_RELATIONSHIP PRIMARY KEY (rel_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'A relationship connects two data structures (of the same type). ';