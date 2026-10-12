/* --------------------------------------------------------------------------------
   DDL for table: t_cardinality_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_CARDINALITY_2 (
   cardinality_cd                      VARCHAR(5)      NOT NULL COMMENT 'A code identifying the cardinality, i.e. 1:1, 1:n or n:m',
   cardinality_name                    VARCHAR(100)    NOT NULL COMMENT 'The full text name for the cardinality, i.e. one-to-one, one-to-many or many-to-many.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CARDINALITY PRIMARY KEY (cardinality_cd) NOT ENFORCED
 )  COMMENT= 'The cardinality of a relationship defines, how many instances of the one data structures are related with how many instances of the other data structures. Cardinalities may be 1:1, 1:n and n:m.';
