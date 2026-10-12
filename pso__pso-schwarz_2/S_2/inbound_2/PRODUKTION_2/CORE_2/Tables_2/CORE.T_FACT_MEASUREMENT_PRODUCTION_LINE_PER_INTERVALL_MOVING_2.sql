--================================================================
-- Table: T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL_MOVING_2
--================================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL_MOVING_2
   generated from Powerdesigner on Mittwoch, 20. September 2023 16:14:15
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL_MOVING_2 (
   PRODUCTION_LINE_RESOURCE_ITEM_SID   NUMBER(38,0)    NOT NULL COMMENT 'Id of the production line',
   SHIFT_ID                            NUMBER(38,0)    NOT NULL COMMENT 'Concatenated ID: shift_start_dt + shift_type_id as integer. Each day has 3 shifts.',
   NAOH_DOSAGE_RES_ITEM_SID            NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   ADDED_ADDITIVE_RES_ITEM_SID         NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   DETERGENT_DOSAGE_RES_ITEM_SID       NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   INTERVAL_FIVE_MIN_HR                NUMBER(38,0)    NOT NULL COMMENT 'The 5 Minute interval of day, i.e.a number in the range from 0 (00:00:00) to 287 (23:54:59) as a number representing 5 minute intervals.',
   NAOH_DOSAGE_QTY                     NUMBER(38, 5)   NOT NULL COMMENT 'Fact - non additive - Represents the quantity of sodium hydroxide solution (NaOH) added to the production line in the last 30 minutes',
   ADDED_ADDITIVE_QTY                  NUMBER(38, 5)   NOT NULL COMMENT 'Fact - non additive - Represents the quantity of additive added to the production line in the last 30 minutes',
   DETERGENT_DOSAGE_RATE               NUMBER(38, 5)   COMMENT 'Fact - non additive - A ration as a result of dividing NaOH_dosage_qty / added_additive_qty.',
   MEASUREMENT_DT                      DATE            NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   MEASUREMENT_TM                      TIME(9)         NOT NULL COMMENT 'Descriptive Attribute - Time of measurement as 5 Minutes intervall e.g. 07:05:00 & stands for intervall from 07:05:00 to 07:04:59',
   MEASUREMENT_TMSP                    TIMESTAMP_TZ(9) NOT NULL COMMENT 'Descriptive Attribute - Represents the point in time of a measurement. Calculation: Time of measurement as 5 Minutes intervall e.g. 07:05:00 & stands for intervall from 07:05:00 to 07:04:59',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL_M PRIMARY KEY (PRODUCTION_LINE_RESOURCE_ITEM_SID, INTERVAL_FIVE_MIN_HR, MEASUREMENT_DT) NOT ENFORCED
 )  COMMENT= 'Fact Table - Analytical - Granularity - 5 Min (updating cycle) per Business Day & 5 Min Interval & Production Line - Aggregate - capturing the the measurements of a production line & calculating every 5 minutes an AVG of last 30 minutes - Source - Fact for measurement_production_line';
