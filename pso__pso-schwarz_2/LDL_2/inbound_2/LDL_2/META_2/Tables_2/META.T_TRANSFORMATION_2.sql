/* --------------------------------------------------------------------------------
   DDL for table: t_transformation_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_TRANSFORMATION_2 (
   transform_cd                        VARCHAR(20)     NOT NULL COMMENT 'A code identifying the set of rules and algorithms which define, how a data object is converted into another data object.',
   transform_name                      VARCHAR(100)    NOT NULL COMMENT 'The name for the set of rules and algorithms which define, how a data object is converted into another data object.',
   transform_descr                     VARCHAR(250)    COMMENT 'A textual description which describes how the transformation is to be used.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_TRANSFORMATION PRIMARY KEY (transform_cd) NOT ENFORCED
 )  COMMENT= 'The transformation defines the set of rules and algorithms which are used to convert one data object into another one. This may include joins, filters and aggregations as well as calculations or formatting operations. Transformations may be defined on the level of data objects or for data elements.';
