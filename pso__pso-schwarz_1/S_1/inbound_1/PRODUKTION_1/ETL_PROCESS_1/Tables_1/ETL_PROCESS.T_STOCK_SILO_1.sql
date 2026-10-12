--==============================================================
-- DBMS name:      Snowflake
-- Created on:     04.04.2025 14:09:00
--==============================================================


--==============================================================
-- Table: T_STOCK_SILO_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_STOCK_SILO_1
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_STOCK_SILO_1 (
	EXTRACTION_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'Represents the point in time of extraction',
	SILO_RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Id of the silo',
	MATERIAL_RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Id of the material',
	FILL_LEVEL_UNIT_ID NUMBER(38,0) NOT NULL COMMENT 'Id of the unit_1 (e.g. material unit_1, production line parameter)',
	FILL_LEVEL_MEAS NUMBER(38,5) NOT NULL COMMENT 'fill level measure in fill_level_units',
        BATCHNAME VARCHAR(100) NOT NULL COMMENT 'Batch Name',
	STOCK_START_TMSP TIMESTAMP_TZ(9) COMMENT 'Represents the point in time of somthing to be analyzed',
     	LIFETIME_SECONDS NUMBER(38,0) COMMENT 'life time',  
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	CONSTRAINT PK_T_STOCK_SILO PRIMARY KEY (SILO_RESOURCE_ITEM_SID, EXTRACTION_TMSP)
)COMMENT='Silo stock data'
;
