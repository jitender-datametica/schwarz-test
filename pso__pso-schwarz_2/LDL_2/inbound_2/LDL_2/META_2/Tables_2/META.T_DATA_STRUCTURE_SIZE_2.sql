/* --------------------------------------------------------------------------------
   DDL for table: t_data_structure_size_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_STRUCTURE_SIZE_2 (
   data_struct_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data structure.',
   meas_tmsp                           TIMESTAMP_TZ(9) NOT NULL COMMENT 'A point in time, identified by a date and a time component.',
   data_struct_size_type_cd            VARCHAR(20)     NOT NULL COMMENT 'The code identifying how the storage space for a data object is measured. E.g. compressed vs. uncompressed size',
   size_meas                           NUMBER(38, 0)   COMMENT 'The size of the data object expressed in the unit_2 of measure (e.g. MB, GB, ...)',
   uom_cd                              VARCHAR(20)     NOT NULL COMMENT 'The code identifying the unit_2 of measure.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_STRUCTURE_SIZE PRIMARY KEY (meas_tmsp, data_struct_size_type_cd, data_struct_sid) NOT ENFORCED
 )  COMMENT= 'This entity tracks the physical size of a data structure (e.g. a table) over time.';
