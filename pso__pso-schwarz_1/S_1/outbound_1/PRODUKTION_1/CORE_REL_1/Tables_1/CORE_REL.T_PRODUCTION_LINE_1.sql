--==============================================================
-- Table: T_PRODUCTION_LINE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_PRODUCTION_LINE_1
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core_rel.t_production_line_1 (
resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production line'),
dwh_valid_from_dt DATE NOT NULL OPTIONS(description='The date when this record became valid.'),
dwh_valid_to_dt DATE NOT NULL OPTIONS(description='The date when this record was no longer valid.'),
plant_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production plant'),
production_line_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Natural Key - For SID generation and lookup'),
production_line_name STRING(100) NOT NULL OPTIONS(description='Natural Key - Name of the production line'),
plant_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - Name of the production plant - a part of natural key to generate SID'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(250)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (resource_item_sid, dwh_valid_from_dt) NOT ENFORCED
) OPTIONS(description='Table with e.g. production lines of all e.g. production plants/factories');