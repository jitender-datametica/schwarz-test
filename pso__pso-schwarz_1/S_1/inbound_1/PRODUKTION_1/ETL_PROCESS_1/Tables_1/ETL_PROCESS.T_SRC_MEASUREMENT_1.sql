--==============================================================
-- DBMS name:      Snowflake
-- Created on:     14.12.2022 11:13:00
--==============================================================


--==============================================================
-- Table: T_SRC_MEASUREMENT_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_SRC_MEASUREMENT_1
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_SRC_MEASUREMENT_1 (
   "SAMPLERATE"                  VARCHAR(100)    NOT NULL COMMENT 'samplerate',
   "FROM"                        VARCHAR(100)    NOT NULL COMMENT 'from',   
   "TO"                          VARCHAR(100)    NOT NULL COMMENT 'to',
   "KEY"                         VARCHAR(100)    NOT NULL COMMENT 'key',
   STATE                         VARCHAR(100)    NOT NULL COMMENT 'state',
   "VALUE"                       VARCHAR(100)    NULL     COMMENT 'value',
   UNIT_1                          VARCHAR(100)    NULL     COMMENT 'unit_1',
   FILENAME                            VARCHAR(199)    NOT NULL COMMENT 'Input file name'
)COMMENT = 'Source table for LMS Measurement (sample data, AVRO)';
