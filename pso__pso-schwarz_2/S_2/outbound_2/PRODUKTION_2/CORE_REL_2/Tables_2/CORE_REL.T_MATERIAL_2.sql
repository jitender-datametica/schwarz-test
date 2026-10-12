--==============================================================
-- Table: T_MATERIAL_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_MATERIAL_2
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core_rel.t_material_2 (
resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the material (e.g. plasting in production plants)'),
dwh_valid_from_dt DATE NOT NULL OPTIONS(description='The date when this record became valid.'),
dwh_valid_to_dt DATE NOT NULL OPTIONS(description='The date when this record was no longer valid.'),
material_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Technical Key (surves as Natural Key) - Material number as a technical identifier of the material from the source system'),
material_name STRING(100) NOT NULL OPTIONS(description='Name of the material'),
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
OPTIONS(description='Table with materials (e.g. plastic materials) which are consumed for a booking during e.g. a production line of a production factory/plant. Source - MES via Proleit ODS (views on SQLServer delivered via Azure Data Factory) coming from SAP.');