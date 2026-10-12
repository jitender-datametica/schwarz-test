/* --------------------------------------------------------------------------------
   DDL for table: t_data_cleansing_log_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_CLEANSING_LOG_2 (
   load_id                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the execution of an ETL job.',
   data_elem_sid                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data element, to which the data cleansing rule has been applied.',
   data_cleansing_rule_name            VARCHAR(100)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the data cleansing rule.',
   rec_cnt                             NUMBER(38, 0)   NOT NULL COMMENT 'The number of records which have been corrected by this data cleansing rule.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_CLEANSING_LOG PRIMARY KEY (data_cleansing_rule_name, data_elem_sid, load_id) NOT ENFORCED
 )  COMMENT= 'ETL jobs need to cater for less than optimal quality in the source data. Depending on the mapping specification certain error scenarios might automatically get corrected. E.g. missing columns in the source record might be filled with default values. This log table tracks, how often a data cleansing rule has been applied.';
