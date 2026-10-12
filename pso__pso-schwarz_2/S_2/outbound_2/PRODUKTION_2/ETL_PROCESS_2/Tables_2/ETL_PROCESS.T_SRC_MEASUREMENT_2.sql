--==============================================================
-- DBMS name:      Snowflake
-- Created on:     14.12.2022 11:13:00
--==============================================================


--==============================================================
-- Table: T_SRC_MEASUREMENT_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_SRC_MEASUREMENT_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_etl_process.t_src_measurement_2 (
samplerate STRING(100) NOT NULL OPTIONS(description='samplerate'),
`from` STRING(100) NOT NULL OPTIONS(description='from'),
`to` STRING(100) NOT NULL OPTIONS(description='to'),
key STRING(100) NOT NULL OPTIONS(description='key'),
state STRING(100) NOT NULL OPTIONS(description='state'),
value STRING(100) OPTIONS(description='value'),
unit_2 STRING(100) OPTIONS(description='unit_2'),
filename STRING(199) NOT NULL OPTIONS(description='Input file name')
) OPTIONS(description='Source table for LMS Measurement (sample data, AVRO)');