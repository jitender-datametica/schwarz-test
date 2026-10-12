--==============================================================
-- Table: T_FACT_MEASUREMENT_SILO_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_MEASUREMENT_SILO_1
   generated from Powerdesigner on Montag, 25. November 2024 10:51:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_fact_measurement_silo_1 (
production_line_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production line'),
warehouse_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the stock (e.g. production)'),
silo_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the silo (e.g. plasting in production plants)'),
mixer_line_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the material mixer line (e.g. mixer line of a production line in a plant)'),
measurement_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Descriptive Attribute - Represents the point in time of a measurement '),
fill_level_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
measurement_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
material_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the material (e.g. plasting in production plants)'),
fill_level_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the unit_1 for the fill level (fill_level_meas).'),
measurement_tm TIME NOT NULL OPTIONS(description='Descriptive Attribute - Time of measurement'),
fill_level_pct BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - non additive - fill level value of silo in percentage. (Value for Fuellstand Silo 01 - Fuellstand Silo 14)'),
fill_level_meas BIGNUMERIC(38,5) OPTIONS(description='Fact - non additive - Material quantity stored in the silo.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (production_line_resource_item_sid, warehouse_resource_item_sid, silo_resource_item_sid,
 mixer_line_resource_item_sid, measurement_tmsp) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional - Periodic Snapshot_1 - capturing the the measurements of a silo - Source - LMS via Proleit ODS (views on SQLServer delivered via Azure Data Factory), IMD (MySQL), Qualifax (MSSQLServer)');