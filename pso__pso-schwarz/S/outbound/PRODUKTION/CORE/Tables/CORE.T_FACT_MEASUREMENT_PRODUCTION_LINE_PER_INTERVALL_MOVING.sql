--================================================================
-- Table: T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL_MOVING
--================================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL_MOVING
   generated from Powerdesigner on Mittwoch, 20. September 2023 16:14:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_fact_measurement_production_line_per_intervall_moving (
production_line_resource_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the production line'),
shift_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Concatenated ID: shift_start_dt + shift_type_id as integer. Each day has 3 shifts.'),
naoh_dosage_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
added_additive_res_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the parameter (e.g. for utilization)'),
detergent_dosage_res_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the parameter (e.g. for utilization)'),
interval_five_min_hr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The 5 Minute interval of day, i.e.a number in the range from 0 (00:00:00) to 287 (23:54:59) as a number representing 5 minute intervals.'),
naoh_dosage_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - non additive - Represents the quantity of sodium hydroxide solution (NaOH) added to the production line in the last 30 minutes'),
added_additive_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - non additive - Represents the quantity of additive added to the production line in the last 30 minutes'),
detergent_dosage_rate BIGNUMERIC(38,5)
OPTIONS(description='Fact - non additive - A ration as a result of dividing NaOH_dosage_qty / added_additive_qty.'),
measurement_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
measurement_tm TIME NOT NULL
OPTIONS(description='Descriptive Attribute - Time of measurement as 5 Minutes intervall e.g. 07:05:00 & stands for intervall from 07:05:00 to 07:04:59'),
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
OPTIONS(description='Fact Table - Analytical - Granularity - 5 Min (updating cycle) per Business Day & 5 Min Interval & Production Line - Aggregate - capturing the the measurements of a production line & calculating every 5 minutes an AVG of last 30 minutes - Source - Fact for measurement_production_line');