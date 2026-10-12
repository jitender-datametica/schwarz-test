--==============================================================
-- Table: T_DIM_PRODUCTION_LINE_PARAMETER_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_PRODUCTION_LINE_PARAMETER_2
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:11 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_dim_production_line_parameter_2 (
resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
dwh_valid_from_dt DATE NOT NULL OPTIONS(description='The date when this record became valid.'),
dwh_valid_to_dt DATE NOT NULL OPTIONS(description='The date when this record was no longer valid.'),
production_line_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production line'),
unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the unit_2 (e.g. material unit_2, production line parameter)'),
production_line_parameter_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key - Parameter number (numeric or alphanumeric). Parameter is generic & can hold values with different units'),
production_line_parameter_name STRING(100) NOT NULL OPTIONS(description='Name of the parameter'),
granularity_type BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Descriptive Attribute - defines the interval in which the parameter values are delivered by sensors. e.g. 1 ,10 or 60 seconds'),
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
OPTIONS(description='Major Dimension - for parameters of a production line in a plant/fabric (e.g. plastic materials), which are sensor values produced & sent to capture the production process & health status. They configurate the mechanics/functionality or utilization of a line & have thresholds. Soruce - 1. LMS via Proleit ODS (views on SQLServer delivered via Azure Data Factory), IMD (MySQL), Qualifax (MSSQLServer) / 2. Manually added as calculated from imported excel file.');