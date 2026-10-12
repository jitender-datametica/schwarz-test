/* --------------------------------------------------------------------------------
   DDL for table: t_data_quality_dimension_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_QUALITY_DIMENSION_2 (
   dq_dimension_cd                     VARCHAR(20)     NOT NULL COMMENT 'A code identifying the basic aspect by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.',
   dq_dimension_name                   VARCHAR(100)    NOT NULL COMMENT 'The name of the basic aspect by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.',
   dq_dimension_descr                  VARCHAR(250)    NOT NULL COMMENT 'The definition of the data quality dimension.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_QUALITY_DIMENSION PRIMARY KEY (dq_dimension_cd) NOT ENFORCED
 )  COMMENT= 'A data quality dimension describes the basic aspects by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.';
