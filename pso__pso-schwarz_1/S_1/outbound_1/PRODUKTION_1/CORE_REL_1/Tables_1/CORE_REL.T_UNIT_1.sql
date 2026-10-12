--==============================================================
-- Table: T_UNIT_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_UNIT_1
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core_rel.t_unit_1 (
unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the unit_1 (e.g. material unit_1, production line parameter)'),
unit_code STRING(100) NOT NULL
OPTIONS(description='Natural Key - Unit_1 code as a technical identifier of the unit_1 from the source system or manually maintained (e.g. degree C)'),
unit_name STRING(100) OPTIONS(description='Full name of the unit_1 (e.g. celsius degree)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(250)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (unit_id) NOT ENFORCED
)
OPTIONS(description='Table with units (e.g. plastic materials, production line parameter). Source - Extracted from metadata durant data delivery process.');