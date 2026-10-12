--==============================================================
-- Table: T_DIM_SILO_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_SILO_1
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_dim_silo_1 (
resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the silo (e.g. plasting in production plants)'),
dwh_valid_from_dt DATE NOT NULL OPTIONS(description='The date when this record became valid.'),
dwh_valid_to_dt DATE NOT NULL OPTIONS(description='The date when this record was no longer valid.'),
silo_cd STRING(100) NOT NULL
OPTIONS(description='Natural Key - silo number as a technical identifier of the material from the source system/production line parameter master data'),
silo_name STRING(100) NOT NULL OPTIONS(description='Name of the silo'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(250)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (resource_item_sid, dwh_valid_from_dt) NOT ENFORCED
)
OPTIONS(description='Major Dimension - with silo which are docked to the production line & are delivering the granulat material for production - Source: Caculated Master Data (indirect) - Extraction from production line parameter master data from defined sensor data. (e.g. Fuellstand Silo 01 - Fuellstand Silo 14)');