--==============================================================
-- Table: T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL_1
   generated from Powerdesigner on Montag, 25. November 2024 10:51:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_fact_measurement_production_line_per_intervall_1 (
production_line_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production line'),
measurement_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
interval_five_min_hr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The 5 Minute interval of day, i.e.a number in the range from 0 (00:00:00) to 287 (23:54:59) as a number representing 5 minute intervals.'),
material_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the material (e.g. plasting in production plants). Output material for a subset of production line parameters like extruder, feeder speed measures'),
avg_feeder_speed_pct_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_bulk_material_balance_buffersilo_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_bulk_material_balance_buffersilo_out_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_bulk_material_balance_washing_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_extruder_output_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_fill_level_reactor_vessel_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_throughput_preform_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_feeder_speed_meas_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_bale_weight_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_feeder_utilization_mill_unit_output_silo_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_feeder_utilization_mill_unit_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_washer_tank_temperature_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_rewasher_tank_temperature_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_inline_iv_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_regranulation_vacuum_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
avg_feeder_speed_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average (granularity of table) feeder speed for this part of the production line. Unit_1 - min'),
avg_feeder_speed_pct BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average (granularity of table) feeder speed for this part of the production line. Unit_1 - percentage'),
avg_feeder_utilization_mill_unit_pct BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average Utilization i.e. power of mill unit_1 (M63) in percent of maximum that is allowed for the cutting mill cutting rests in the sieve into smaller pieces. Unit_1 - Percentage'),
avg_feeder_utilization_mill_unit_output_silo_pct BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average Utilization i.e. power of feeding unit_1 (M53) in percent of maximum that is allowed for output of the push floor silo (this silo is part of production line, not a stock silo). Unit_1 - Percentage'),
avg_bulk_material_balance_buffersilo_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average (granularity of table) amount of material after the buffer silo/ at the beginning of the cleansing step. Unit_1 - kg'),
avg_bulk_material_balance_buffersilo_out_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average of current amount of material after the buffer silo/ at the end of the cleansing step. Unit_1 - kg'),
avg_bulk_material_balance_washing_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average (granularity of table) amount of material  at the beginning of the cleansing step on line washing 02 (assumption all washing production lines work the same). Unit_1 - kg'),
avg_extruder_output_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average (granularity of table) value of extruder output measured on melting pump. Unit_1 - kg/h'),
avg_fill_level_reactor_vessel_pct BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Fill level of the regranulation reactor vessel. Unit_1 - percentage'),
avg_throughput_preform_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average throughput of performs measured by 60* ((60/cycle_time_qty)* cavity_qty). Unit_1 - pieces. '),
avg_bale_weight_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average weight of plastic bale for this part of the production line. Unit_1 - kg'),
avg_washer_tank_temperature_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average Washing tank temperature. Unit_1 - Degree Celcius.'),
avg_rewasher_tank_temperature_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average Re_1-washing tank temperature. Unit_1 - Degree Celcius.'),
avg_eta_box_temperature_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average (granularity of table) of temperature of eta box of the dryer in preform process. Unit_1 - Degree Celcius'),
avg_heating_box_temperature_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average (granularity of table) of temperature of heating box of the dryer in preform process. Unit_1 - Degree Celcius'),
avg_booster_temperature_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average (granularity of table) of temperature of booster of the dryer in preform process. Unit_1 - Degree Celcius'),
avg_dryer_dew_point_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average (granularity of table) of dew point of the dryer in preform process. Unit_1 - Degree Celcius'),
avg_inline_iv_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average Inline value of iv (intrinsic viscosity) within the melting of extruder melting pump. Unit_1 - 2Do'),
avg_regranulation_vacuum_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Average Regranulation measurement of vacuum at reactor. Unit_1 - Millibar.'),
measurement_tm TIME NOT NULL
OPTIONS(description='Descriptive Attribute - Time of measurement as 5 Minutes intervall e.g. 07:10:00 & stands for intervall from 07:10:00 to 07:09:59'),
measurement_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Descriptive Attribute - Represents the point in time of a measurement. Calculation: Time of measurement as 5 Minutes intervall e.g. 07:05:00 & stands for intervall from 07:05:00 to 07:04:59'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (production_line_resource_item_sid, interval_five_min_hr, measurement_dt) NOT ENFORCED
)
OPTIONS(description='Fact Table - Analytical - Granularity - 5 Min (updating cycle) per Business Day & 5 Min Interval & Material & & Production Line - Aggregate - capturing the the measurements of a production line & calculating every 5 minutes for defined measures. Due to missing values & time intervals with no produced data by sensors it is possible to have nullable measure values (measures are dense) - Source - Fact for measurement_production_line');