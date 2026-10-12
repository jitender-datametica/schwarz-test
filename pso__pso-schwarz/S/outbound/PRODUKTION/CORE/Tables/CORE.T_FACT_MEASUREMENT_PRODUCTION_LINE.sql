--==============================================================
-- Table: T_FACT_MEASUREMENT_PRODUCTION_LINE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_MEASUREMENT_PRODUCTION_LINE
   generated from Powerdesigner on Montag, 25. November 2024 10:51:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_fact_measurement_production_line (
production_line_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production line'),
measurement_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
interval_min_hr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The 1 Minute interval of day, i.e.a number in the range from 0 (00:00:00) to 1440 (23:54:59) as a number representing 1 minute intervals.'),
material_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the material (e.g. plastic in production plants). Output material for a subset of production line parameters like extruder, feeder speed measures'),
shift_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Concatenated ID: shift_start_dt + shift_type_id as integer. Each day has 3 shifts.'),
cavity_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
inop_cavity_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
total_cavity_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
cycle_time_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
cta_iv_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
cta_iv_prediction_fit_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
inline_iv_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
pdu_return_temperature_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
extruder_output_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
zone_18_melting_pump_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
zone_4_adapter_de_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
nitrogen_flow_ssp_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
target_retentiontime_ssp_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
feeder_speed_meas_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
feeder_speed_pct_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
bulk_material_balance_buffersilo_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
bulk_material_balance_buffersilo_out_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
fill_level_reactor_vessel_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
throughput_preform_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
booster_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
dryer_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
material_section_move_prediction_cond_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
material_output_prediction_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
bulk_material_balance_washing_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
bulk_material_balance_washing_feeder_left_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
bulk_material_balance_washing_feeder_right_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
feeder_utilization_mill_unit_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
feeder_utilization_mill_unit_output_silo_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
washer_tank_temperature_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
bale_weight_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
regranulation_vacuum_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
washer_tank_conduct_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
rewasher_tank_temperature_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
eta_box_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
heating_box_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
content_container_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
machine_status_cd BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The code for the status of the machine.'),
cavity_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - amount of used cavities (forms) of tool on an injection molding production machine dependent on the production line. '),
inop_cavity_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - amount of unused cavities (forms) of tool on an injection molding production machine dependent on the production line. '),
total_cavity_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - amount of used and unused cavities (forms) of tool on an injection molding production machine dependent on the production line. '),
cycle_time_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - cycle time of injection molding production machine dependent on the production line'),
cta_iv_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - IV measurement value lab of QS(quality service) of current of re-granulate material dependent on the production line. Unit - 2Do'),
cta_iv_prediction_fit_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - forcast (model calculated) IV measurement value of material production as output dependent on the production line. Unit - 2Do'),
inline_iv_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Inline value of iv (intrinsic viscosity) within the melting of extruder melting pump. Unit - 2Do'),
pdu_return_temperature_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Return temperature of hot air, which is used for drying & heating of extruder pre-drying unit. Unit - degree C.'),
extruder_output_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Current value of extruder output measured on melting pump. Unit - kg/h'),
zone_18_melting_pump_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Temperature measured in melting pump of the extruder. Unit - degree C'),
zone_4_adapter_de_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Temperature measured in heating zone of the extruder. Unit - degree C'),
nitrogen_flow_ssp_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Current value of nitrogen flow within the Solid State Reactor - Unit l/h'),
target_retentiontime_ssp_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Retention time in Solid State Reactor for running the polycondensation reaction & decontamination of previous extruded granulate'),
feeder_speed_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Current rotation speed of the screw conveyor. Unit - min-1'),
feeder_speed_pct BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Calculated feeding speed using the recovery amount and the value of detected good material by the Tomra sorter. Unit - percentage'),
bulk_material_balance_buffersilo_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Current amount of material after the buffer silo/ at the beginning of the cleansing step. Unit - kg'),
bulk_material_balance_buffersilo_out_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Current amount of material after the buffer silo/ at the end of the cleansing step. Unit - kg'),
bulk_material_balance_washing_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Calculated amount of bulk material on production line washing 02. Sum of bulk_material_balance_BBBX_meas(kg), bulk_material_balance_BBBY_meas(kg), bulk_material_balance_amount_meas(tons) * 1000. Unit - kg'),
bulk_material_balance_washing_feeder_left_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Amount of bulk material with BBBX (stays for big bag left side) feed pipe on production line washing 02. Unit - kg'),
bulk_material_balance_washing_feeder_right_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Calculated amount of bulk material with BBBY (stays for big bag right side) on production line washing 02. Unit - kg'),
fill_level_reactor_vessel_pct BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Fill level of the regranulation reactor vessel. Unit - percentage'),
throughput_preform_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Calculated throughput using the active cavities and the cycle time. Calculation: 60 * ((60/CYCLE_TIME_QTY) * CAVITY_QTY)'),
material_output_prediction_meas BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - non additive - Predicted unix timestamp as integer value of material output (production is finished), from which the produced material leaves the production line (QFXtime).             A manual labor measurement in Qualifax-System (CTA_IV) can be done forst after this timestamp. Target: input for R-Script calculation.'),
feeder_utilization_mill_unit_pct BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Utilization i.e. power of mill unit (M63) in percent of maximum that is allowed for the cutting mill cutting rests in the sieve into smaller pieces. Unit - Percentage'),
feeder_utilization_mill_unit_output_silo_pct BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Utilization i.e. power of feeding unit (M53) in percent of maximum that is allowed for output of the push floor silo (this silo is part of production line, not a stock silo). Unit - Percentage'),
washer_tank_temperature_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Washing tank temperature. Unit - Degree Celcius.'),
washer_tank_conduct_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Washing tank conductability. Unit - Siemens per meter S/m.'),
rewasher_tank_temperature_meas BIGNUMERIC(38,0)
OPTIONS(description='Fact - non additive - Re-washing tank temperature. Unit - Degree Celcius.'),
eta_box_temperature_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Temperature of eta box of the dryer in preform process. Unit - Degree Celcius'),
heating_box_temperature_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Temperature of heating box of the dryer in preform process. Unit - Degree Celcius'),
booster_temperature_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Temperature of booster of the dryer in preform process. Unit - Degree Celcius'),
dryer_dew_point_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Dew point of the dryer in preform process. Unit - Degree Celcius'),
bale_weight_qty BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Weight of plastic bale currently used on production line'),
regranulation_vacuum_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - Regranulation measurement of vacuum at reactor. Unit - Millibar.'),
material_section_move_prediction_cond_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Descriptive Attribute - Predicted status (as a value of CTA_ETA) of arrival of the next production line plant section.             Possible production line sections in a plastic plant are 1-6. The measured timestamp of the status is presumably the timestamp of movement of processed material to the next section.            The status value shows the delivering section in reverse order. e.g. CTA_ETA = 6: material moves from production line section 1 to 2. CTA_ETA = 1: material moves to the last production line section.            '),
content_container_qty BIGNUMERIC(38,5) OPTIONS(description='Fact - non additive - contents of the current container.'),
preform_downtime_fg BOOL NOT NULL
OPTIONS(description='Descriptive Attribute - Depending on the measured values within the preforms this flag will be set to "1" if the measurement shows the same value 5 times in a row indicating a downtime in the preform area of a production line'),
measurement_tm TIME NOT NULL OPTIONS(description='Descriptive Attribute - Time of measurement'),
measurement_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Descriptive Attribute - Represents the point in time of a measurement '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (production_line_resource_item_sid, interval_min_hr, measurement_dt) NOT ENFORCED
)
OPTIONS(description='Transactional Facts - Periodic Snapshot - capturing the the measurements of a production line every 1 minute interval. Source - LMS via Proleit ODS (views on SQLServer delivered via Azure Data Factory), IMD (MySQL), Qualifax (MSSQLServer). Current status on 02.2022 the thresholds of all extruder & feeder speed (avg or percent) measures are dependent on material.');