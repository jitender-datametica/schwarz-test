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


CREATE TABLE IF NOT EXISTS produktion_etl_process.t_stock_silo_1 (
extraction_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Represents the point in time of extraction'),
silo_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the silo'),
material_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the material'),
fill_level_unit_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the unit_1 (e.g. material unit_1, production line parameter)'),
fill_level_meas BIGNUMERIC(38,5) NOT NULL OPTIONS(description='fill level measure in fill_level_units'),
batchname STRING(100) NOT NULL OPTIONS(description='Batch Name'),
stock_start_tmsp TIMESTAMP
OPTIONS(description='Represents the point in time of somthing to be analyzed'),
lifetime_seconds BIGNUMERIC(38,0) OPTIONS(description='life time'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (silo_resource_item_sid, extraction_tmsp) NOT ENFORCED
) OPTIONS(description='Silo stock data');