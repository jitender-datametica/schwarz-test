--==============================================================
-- Table: T_FACT_THRESHOLD_PARAMETER_PER_MATERIAL_REL
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_THRESHOLD_PARAMETER_PER_MATERIAL_REL
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_fact_threshold_parameter_per_material_rel (
production_line_parameter_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the production line parameter'),
material_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the material (e.g. plasting in production plants)'),
min_val BIGNUMERIC(38,5) OPTIONS(description='Minimum value on the scale for a chosen parameter'),
max_val BIGNUMERIC(38,5) OPTIONS(description='Maximum value on the scale for a chosen parameter'),
lower_warning_limit_val BIGNUMERIC(38,5)
OPTIONS(description='Lower warning limit is dependent on production line parameter. Upper & lower warning limits describe a range in which the material production is considered to be optimal. In case of falling out of the range a readjustion will take place aiming to come back into the range.'),
upper_warning_limit_val BIGNUMERIC(38,5)
OPTIONS(description='Upper warning limit is dependent on production line parameter. Upper & lower warning limits describe a range in which the material production is considered to be optimal. In case of falling out of the range a readjustion will take place aiming to come back into the range.'),
target_val BIGNUMERIC(38,5) OPTIONS(description='Target value on the scale for a chosen parameter'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(250)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (production_line_parameter_resource_item_sid, material_resource_item_sid) NOT ENFORCED
)
OPTIONS(description='Bridge Factless Facts - Periodic Snapshot - capturing the the thresholds dependent on production parameter line & material. Source: Caculated from Master Data (indirect) - Extraction from production line parameter master data from defined sensor data. Current status on 02.2022 the thresholds of all extruder & feeder speed (avg or percent) measures are dependent on material.');