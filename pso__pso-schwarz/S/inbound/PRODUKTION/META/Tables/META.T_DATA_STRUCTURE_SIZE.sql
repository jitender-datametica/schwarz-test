--==============================================================
-- Table: T_DATA_STRUCTURE_SIZE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DATA_STRUCTURE_SIZE
   generated from Powerdesigner on Freitag, 17. M�rz 2023 11:02:24
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_DATA_STRUCTURE_SIZE (
   DATA_STRUCT_SID                     NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) of the data structure.',
   MEAS_TMSP                           TIMESTAMP_TZ(9) NOT NULL COMMENT 'A point in time, identified by a date and a time component.',
   DATA_STRUCT_SIZE_TYPE_CD            VARCHAR(50)     NOT NULL COMMENT 'The code identifying how the storage space for a data object is measured. E.g. compressed vs. uncompressed size',
   SIZE_MEAS                           NUMBER(38, 5)   COMMENT 'The size of the data object expressed in the unit of measure (e.g. MB, GB, ...)',
   UOM_CD                              VARCHAR(50)     NOT NULL COMMENT 'The code identifying the unit of measure.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_STRUCTURE_SIZE PRIMARY KEY (MEAS_TMSP, DATA_STRUCT_SIZE_TYPE_CD, DATA_STRUCT_SID) NOT ENFORCED
 )  COMMENT= 'This entity tracks the physical size of a data structure (e.g. a table) over time.';

