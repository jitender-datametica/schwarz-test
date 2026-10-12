--==============================================================
-- Table: T_PLANT_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_PLANT_2
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:11 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core_rel.t_plant_2 (
resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production plant'),
dwh_valid_from_dt DATE NOT NULL OPTIONS(description='The date when this record became valid.'),
dwh_valid_to_dt DATE NOT NULL OPTIONS(description='The date when this record was no longer valid.'),
odsareakey_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Natural Key - Use for SID generation'),
plant_name STRING(100) NOT NULL OPTIONS(description='Natural Key - Name of the production plant'),
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
OPTIONS(description='Table with all possible plants in production division. Plant is a locally separated organisational production unit_2, that produces material goods.');