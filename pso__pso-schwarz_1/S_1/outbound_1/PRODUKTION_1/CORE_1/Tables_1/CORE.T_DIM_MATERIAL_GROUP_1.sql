--==============================================================
-- Table: T_DIM_MATERIAL_GROUP_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_MATERIAL_GROUP_1
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_dim_material_group_1 (
resource_item_group_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the material groups'),
dwh_valid_from_dt DATE NOT NULL OPTIONS(description='The date when this record became valid.'),
dwh_valid_to_dt DATE NOT NULL OPTIONS(description='The date when this record was no longer valid.'),
material_group_nr STRING(100) NOT NULL
OPTIONS(description='Natural Key - Material group number as a technical identifier of the material group from the source system/table'),
material_group_name STRING(100) OPTIONS(description='Name of the material group (if existing)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(250)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (resource_item_group_sid, dwh_valid_from_dt) NOT ENFORCED
)
OPTIONS(description='Major Dimension - Table with material groups (e.g. for plastic materials). Materials are consumed for a booking during e.g. a production line of a production factory/plant. Source - extracted from t_booking_1 attribute (persistency of a degenerated dimension).');