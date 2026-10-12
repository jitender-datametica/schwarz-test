--==============================================================
-- Table: T_MEASUREMENT_PRODUCTION_LINE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_MEASUREMENT_PRODUCTION_LINE
   generated from Powerdesigner on Montag, 26. Juni 2023 19:26:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core_rel.t_measurement_production_line (
production_line_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production line'),
shift_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Concatenated ID: shift_start_dt + shift_type_id as integer. Each day has 3 shifts.'),
measurement_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Represents the point in time of a measurement '),
production_line_parameter_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the unit (e.g. material unit, production line parameter)'),
measurement_dt DATE NOT NULL
OPTIONS(description='Descriptive Attribute - The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
measurement_tm TIME NOT NULL OPTIONS(description='Descriptive Attribute - Time of measurement'),
value_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - non additive value the parameter of the specified production line'),
measurement_delivery_state_txt STRING(1000)
OPTIONS(description='Measurements are qualified as beeing valid, invalid or are considered as empty. Info is defined by source system. Reason has to be clarified by BSE'),
measurement_delivery_sample_rate BIGNUMERIC(38,5) DEFAULT - 1 NOT NULL
OPTIONS(description='Measurements are delivered in different time intervalls, described as sample rate. Originall sample rates are 1, 10, 60 sec. o stays for unspecified/continuosly changing value. -1 stays for unknow (not delivered from source system) / default value.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (production_line_resource_item_sid, shift_id, production_line_parameter_resource_item_sid, measurement_tmsp
 ) NOT ENFORCED
)
OPTIONS(description='Transactional Facts - Generic modeled with granularity normalized to 60 Secs (originally delivered as 1, 10, 60 sec measurements) - capturing the the measurements of a production line. The values are results of sensor data activity on different parts of production line monitoring manufaturing process. Source - LMS via Proleit ODS (views on SQLServer delivered via Azure Data Factory), IMD (MySQL), Qualifax (MSSQLServer)');