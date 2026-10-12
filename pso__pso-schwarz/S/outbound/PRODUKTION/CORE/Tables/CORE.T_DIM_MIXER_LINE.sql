--==============================================================
-- Table: T_DIM_MIXER_LINE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_MIXER_LINE
   generated from Powerdesigner on Montag, 25. November 2024 10:51:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_dim_mixer_line (
resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the material mixer line (e.g. mixer line of a production line in a plant)'),
dwh_valid_from_dt DATE NOT NULL OPTIONS(description='The date when this record became valid.'),
dwh_valid_to_dt DATE NOT NULL OPTIONS(description='The date when this record was no longer valid.'),
production_line_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the production line (e.g. production line in a plant)'),
mixer_line_cd STRING(100) NOT NULL
OPTIONS(description='Natural Key - code as a technical identifier of the material mixer line from the source system/production line parameter master data'),
mixer_line_name STRING(100) NOT NULL OPTIONS(description='Name of the material mixer line'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (resource_item_sid, dwh_valid_from_dt) NOT ENFORCED
)
OPTIONS(description='Major Dimension - Material-Mixer line (Material-Mischerstrang) are technical constructions as a part of a production line (up to 4 pieces). They are permanently connected to the production line. A silo can be flexibly docked mixer line for delivering the granulat material. Source: Caculated Master Data (indirect) - Extraction from production line parameter master data from defined sensor data. (e.g. Paramter MVA_L2_0_MAG01_164 - MVA_L2_0_MAG01_170 with description Mischer 1 Quelle 1 - Mischer 1 Quelle 4)');