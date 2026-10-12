--==============================================================
-- DBMS name:      Snowflake
-- Created on:     17.02.2022 11:13:00
--==============================================================


--==============================================================
-- Table: T_SRC_QUALIFAX_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_SRC_QUALIFAX_1
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_SRC_QUALIFAX_1 (
   P315_PROBENAHME               TIMESTAMP_LTZ(6) NULL     COMMENT 'p315_probenahme',
   P523_AUFTRAGNR                NUMBER(38,0)     NULL     COMMENT 'p523_auftragnr',
   P504_MATERIAL                 VARCHAR(250)     NULL     COMMENT 'p504_material',
   EBWNUM                        NUMBER(38,9)     NULL     COMMENT 'ebwnum',
   BEWCHUPDDT                    TIMESTAMP_LTZ(6) NULL     COMMENT 'bewchupddt',
   S303_ANLAGE                   NUMBER(38,0)     NULL     COMMENT 's303_anlage',
   P303_ANLAGE                   VARCHAR(250)     NULL     COMMENT 'p303_anlage',  
   FILENAME                      VARCHAR(250)     NULL     COMMENT 'Input file name'
)COMMENT = 'Source table for Qualifax Measurement';
