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

CREATE TABLE ETL_PROCESS.T_HGA_PAYMENT_TYPE_MAP_2 (
  HGA_VERSION NUMBER(38,0) NOT NULL COMMENT 'HGA source file version',
  SRC_PAYMENT_TYPE VARCHAR(100) NOT NULL COMMENT 'Payment type coming from machines',
  PAYMENT_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The code for the payment type',
CONSTRAINT PK_T_HGA_PAYMENT_TYPE_MAP PRIMARY KEY (HGA_VERSION, SRC_PAYMENT_TYPE)
)COMMENT='Mapping table from incoming payment Types to PAYMENT_TYPE_ID'
;
