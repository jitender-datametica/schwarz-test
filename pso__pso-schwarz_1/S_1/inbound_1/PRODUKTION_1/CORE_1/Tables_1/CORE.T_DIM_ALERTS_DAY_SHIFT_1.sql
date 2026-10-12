--==============================================================
-- DBMS name:      Snowflake
-- Created on:     17.03.2021 15:26:08
--==============================================================


--==============================================================
-- Table: T_DIM_ALERTS_DAY_SHIFT_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_ALERTS_DAY_SHIFT_1
   generated from Powerdesigner on Donnerstag, 25. März 2021 11:12:37
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ALERTS_DAY_SHIFT_1 (
   ALERTS_DAY_SHIFT_ID                 NUMBER          NOT NULL COMMENT 'Concatenated ID: alerts_day_shift_start_dt + alerts_shift_description_id as integer. Each day has 3 shifts.',
   ALERTS_DAY_SHIFT_END_DT             DATE            NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   ALERTS_DAY_SHIFT_START_DT           DATE            NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   ALERTS_SHIFT_DESCRIPTION_ID         NUMBER          NOT NULL COMMENT 'The unique identifier for the shift description.',
   ALERTS_DAY_SHIFT_START_TM           TIME            NOT NULL COMMENT 'The time represented as a timestamp of the format hh:mm_1:ss at which a specifc shift is starting.',
   ALERTS_DAY_SHIFT_END_TM             TIME            NOT NULL COMMENT 'The time represented as a timestamp of the format hh:mm_1:ss at which a specifc shift is ending.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_DIM_ALERTS_DAY_SHIFT PRIMARY KEY (ALERTS_DAY_SHIFT_ID)
       NOT enforced
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Dimension table with all possible shifts per production day.';
