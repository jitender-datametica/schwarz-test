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

CREATE TABLE ETL_PROCESS.T_HGA_PRODUCT_MAP_1 (
  HGA_VERSION NUMBER(38,0) NOT NULL COMMENT 'HGA source file version',
  COUNTRY_POL_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying a political country_1 according to ISO 3166.',
  SRC_PRODUCT_NUMBER NUMBER(38,0) NOT NULL COMMENT 'Product number coming from machines in this country_1',
  HGA_PRODUCT_CAT_ID NUMBER(38,0) NOT NULL COMMENT 'The code for a hot beverage product',
  HGA_PRODUCT_SUB_CAT_ID NUMBER(38,0) NOT NULL COMMENT 'The sub-code for a hot beverage product',
CONSTRAINT PK_T_HGA_PRODUCT_MAP PRIMARY KEY (HGA_VERSION, COUNTRY_POL_CD, SRC_PRODUCT_NUMBER)
)COMMENT='Mapping table from incoming product numbers to HGA_PRODUCT_CAT_ID and HGA_PRODUCT_SUB_CAT_ID'
;
