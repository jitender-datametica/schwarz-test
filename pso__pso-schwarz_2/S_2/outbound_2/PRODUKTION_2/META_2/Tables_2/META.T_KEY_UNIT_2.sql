--==============================================================
-- DBMS name:      Snowflake
-- Created on:     18.11.2021 15:26:08
--==============================================================


--==============================================================
-- Table: T_KEY_UNIT_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_KEY_UNIT_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_meta.t_key_unit_2 (
src_01_cd STRING(100) NOT NULL OPTIONS(description='Source system key 01'),
src_namespace_cd STRING(100) NOT NULL OPTIONS(description='Name space code for source system key'),
unit_id BIGNUMERIC NOT NULL OPTIONS(description='Unit_2 ID'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (src_01_cd, src_namespace_cd) NOT ENFORCED
) OPTIONS(description='Key table for units');