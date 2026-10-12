--==============================================================
-- DBMS name:      Snowflake
-- Created on:     17.02.2022 11:13:00
--==============================================================


--==============================================================
-- Table: T_SRC_QUALIFAX
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_SRC_QUALIFAX
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_etl_process.t_src_qualifax (
p315_probenahme TIMESTAMP OPTIONS(description='p315_probenahme'),
p523_auftragnr BIGNUMERIC(38,0) OPTIONS(description='p523_auftragnr'),
p504_material STRING(250) OPTIONS(description='p504_material'),
ebwnum NUMERIC(38,9) OPTIONS(description='ebwnum'),
bewchupddt TIMESTAMP OPTIONS(description='bewchupddt'),
s303_anlage BIGNUMERIC(38,0) OPTIONS(description='s303_anlage'),
p303_anlage STRING(250) OPTIONS(description='p303_anlage'),
filename STRING(250) OPTIONS(description='Input file name')
) OPTIONS(description='Source table for Qualifax Measurement');