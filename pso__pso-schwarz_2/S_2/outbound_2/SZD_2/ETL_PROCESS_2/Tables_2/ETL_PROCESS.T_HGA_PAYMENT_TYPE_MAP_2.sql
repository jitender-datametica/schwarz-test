--==============================================================
-- DBMS name:      Snowflake
-- Created on:     03.10.2025 16:34:00
--==============================================================


--==============================================================
-- Table: T_HGA_PAYMENT_TYPE_MAP_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_HGA_PAYMENT_TYPE_MAP_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_etl_process.t_hga_payment_type_map_2 (
hga_version BIGNUMERIC(38,0) NOT NULL OPTIONS(description='HGA source file version'),
src_payment_type STRING(100) NOT NULL OPTIONS(description='Payment type coming from machines'),
payment_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The code for the payment type'),
PRIMARY KEY (hga_version, src_payment_type) NOT ENFORCED
) OPTIONS(description='Mapping table from incoming payment Types to PAYMENT_TYPE_ID');