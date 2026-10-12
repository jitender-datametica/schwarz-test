--==============================================================
-- DBMS name:      Snowflake
-- Created on:     08.04.2025 11:16:00
--==============================================================


--==============================================================
-- Table: T_HGA_PRODUCT_MAP_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_HGA_PRODUCT_MAP_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_etl_process.t_hga_product_map_1 (
hga_version BIGNUMERIC(38,0) NOT NULL OPTIONS(description='HGA source file version'),
country_pol_cd STRING(3) NOT NULL OPTIONS(description='The code identifying a political country_1 according to ISO 3166.'),
src_product_number BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Product number coming from machines in this country_1'),
hga_product_cat_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The code for a hot beverage product'),
hga_product_sub_cat_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The sub-code for a hot beverage product'),
PRIMARY KEY (hga_version, country_pol_cd, src_product_number) NOT ENFORCED
) OPTIONS(description='Mapping table from incoming product numbers to HGA_PRODUCT_CAT_ID and HGA_PRODUCT_SUB_CAT_ID');