--==============================================================
-- Table: T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL
   generated from Powerdesigner on Montag, 25. November 2024 10:51:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL (
   PRODUCTION_LINE_RESOURCE_ITEM_SID   NUMBER(38,0)    NOT NULL COMMENT 'Id of the production line',
   MEASUREMENT_DT                      DATE            NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). ',
   INTERVAL_FIVE_MIN_HR                NUMBER(38,0)    NOT NULL COMMENT 'The 5 Minute interval of day, i.e.a number in the range from 0 (00:00:00) to 287 (23:54:59) as a number representing 5 minute intervals.',
   MATERIAL_RESOURCE_ITEM_SID          NUMBER(38,0)    NOT NULL COMMENT 'Id of the material (e.g. plasting in production plants). Output material for a subset of production line parameters like extruder, feeder speed measures',
   AVG_FEEDER_SPEED_PCT_RES_ITEM_SID   NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_BULK_MATERIAL_BALANCE_BUFFERSILO_RES_ITEM_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_BULK_MATERIAL_BALANCE_BUFFERSILO_OUT_RES_ITEM_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_BULK_MATERIAL_BALANCE_WASHING_RES_ITEM_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_EXTRUDER_OUTPUT_RES_ITEM_SID    NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_FILL_LEVEL_REACTOR_VESSEL_RES_ITEM_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_THROUGHPUT_PREFORM_RES_ITEM_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_FEEDER_SPEED_MEAS_RES_ITEM_SID  NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_BALE_WEIGHT_RES_ITEM_SID        NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_FEEDER_UTILIZATION_MILL_UNIT_OUTPUT_SILO_RES_ITEM_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_FEEDER_UTILIZATION_MILL_UNIT_RES_ITEM_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_WASHER_TANK_TEMPERATURE_RES_ITEM_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_REWASHER_TANK_TEMPERATURE_RES_ITEM_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_INLINE_IV_RES_ITEM_SID          NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_REGRANULATION_VACUUM_RES_ITEM_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   AVG_FEEDER_SPEED_MEAS               NUMBER(38, 5)   COMMENT 'Fact - non additive - Average (granularity of table) feeder speed for this part of the production line. Unit - min',
   AVG_FEEDER_SPEED_PCT                NUMBER(38, 5)   COMMENT 'Fact - non additive - Average (granularity of table) feeder speed for this part of the production line. Unit - percentage',
   AVG_FEEDER_UTILIZATION_MILL_UNIT_PCT NUMBER(38, 5)   COMMENT 'Fact - non additive - Average Utilization i.e. power of mill unit (M63) in percent of maximum that is allowed for the cutting mill cutting rests in the sieve into smaller pieces. Unit - Percentage',
   AVG_FEEDER_UTILIZATION_MILL_UNIT_OUTPUT_SILO_PCT NUMBER(38, 5)   COMMENT 'Fact - non additive - Average Utilization i.e. power of feeding unit (M53) in percent of maximum that is allowed for output of the push floor silo (this silo is part of production line, not a stock silo). Unit - Percentage',
   AVG_BULK_MATERIAL_BALANCE_BUFFERSILO_MEAS NUMBER(38, 5)   COMMENT 'Fact - non additive - Average (granularity of table) amount of material after the buffer silo/ at the beginning of the cleansing step. Unit - kg',
   AVG_BULK_MATERIAL_BALANCE_BUFFERSILO_OUT_MEAS NUMBER(38, 5)   COMMENT 'Fact - non additive - Average of current amount of material after the buffer silo/ at the end of the cleansing step. Unit - kg',
   AVG_BULK_MATERIAL_BALANCE_WASHING_MEAS NUMBER(38, 5)   COMMENT 'Fact - non additive - Average (granularity of table) amount of material  at the beginning of the cleansing step on line washing 02 (assumption all washing production lines work the same). Unit - kg',
   AVG_EXTRUDER_OUTPUT_MEAS            NUMBER(38, 5)   COMMENT 'Fact - non additive - Average (granularity of table) value of extruder output measured on melting pump. Unit - kg/h',
   AVG_FILL_LEVEL_REACTOR_VESSEL_PCT   NUMBER(38, 5)   COMMENT 'Fact - non additive - Fill level of the regranulation reactor vessel. Unit - percentage',
   AVG_THROUGHPUT_PREFORM_QTY          NUMBER(38, 5)   COMMENT 'Fact - non additive - Average throughput of performs measured by 60* ((60/cycle_time_qty)* cavity_qty). Unit - pieces. ',
   AVG_BALE_WEIGHT_QTY                 NUMBER(38, 5)   COMMENT 'Fact - non additive - Average weight of plastic bale for this part of the production line. Unit - kg',
   AVG_WASHER_TANK_TEMPERATURE_MEAS    NUMBER(38, 5)   COMMENT 'Fact - non additive - Average Washing tank temperature. Unit - Degree Celcius.',
   AVG_REWASHER_TANK_TEMPERATURE_MEAS  NUMBER(38, 5)   COMMENT 'Fact - non additive - Average Re-washing tank temperature. Unit - Degree Celcius.',
   AVG_ETA_BOX_TEMPERATURE_MEAS        NUMBER(38, 5)   COMMENT 'Fact - non additive - Average (granularity of table) of temperature of eta box of the dryer in preform process. Unit - Degree Celcius',
   AVG_HEATING_BOX_TEMPERATURE_MEAS    NUMBER(38, 5)   COMMENT 'Fact - non additive - Average (granularity of table) of temperature of heating box of the dryer in preform process. Unit - Degree Celcius',
   AVG_BOOSTER_TEMPERATURE_MEAS        NUMBER(38, 5)   COMMENT 'Fact - non additive - Average (granularity of table) of temperature of booster of the dryer in preform process. Unit - Degree Celcius',
   AVG_DRYER_DEW_POINT_MEAS            NUMBER(38, 5)   COMMENT 'Fact - non additive - Average (granularity of table) of dew point of the dryer in preform process. Unit - Degree Celcius',
   AVG_INLINE_IV_MEAS                  NUMBER(38, 5)   COMMENT 'Fact - non additive - Average Inline value of iv (intrinsic viscosity) within the melting of extruder melting pump. Unit - 2Do',
   AVG_REGRANULATION_VACUUM_MEAS       NUMBER(38, 5)   COMMENT 'Fact - non additive - Average Regranulation measurement of vacuum at reactor. Unit - Millibar.',
   MEASUREMENT_TM                      TIME(9)         NOT NULL COMMENT 'Descriptive Attribute - Time of measurement as 5 Minutes intervall e.g. 07:10:00 & stands for intervall from 07:10:00 to 07:09:59',
   MEASUREMENT_TMSP                    TIMESTAMP_TZ(9) NOT NULL COMMENT 'Descriptive Attribute - Represents the point in time of a measurement. Calculation: Time of measurement as 5 Minutes intervall e.g. 07:05:00 & stands for intervall from 07:05:00 to 07:04:59',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL PRIMARY KEY (PRODUCTION_LINE_RESOURCE_ITEM_SID, INTERVAL_FIVE_MIN_HR, MEASUREMENT_DT) NOT ENFORCED
 )  COMMENT= 'Fact Table - Analytical - Granularity - 5 Min (updating cycle) per Business Day & 5 Min Interval & Material & & Production Line - Aggregate - capturing the the measurements of a production line & calculating every 5 minutes for defined measures. Due to missing values & time intervals with no produced data by sensors it is possible to have nullable measure values (measures are dense) - Source - Fact for measurement_production_line';

