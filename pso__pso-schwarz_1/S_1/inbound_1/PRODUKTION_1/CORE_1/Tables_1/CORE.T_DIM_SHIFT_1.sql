--==============================================================
-- Table: T_DIM_SHIFT_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_SHIFT_1
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:11 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_SHIFT_1 (
   SHIFT_ID                            NUMBER(38,0)    NOT NULL COMMENT 'Concatenated ID: shift_start_dt + shift_type_id as integer. Each day has 3 shifts.',
   SHIFT_TYPE_ID                       NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier for the shift type.',
   SHIFT_START_DT                      DATE            NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   SHIFT_END_DT                        DATE            NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   SHIFT_TYPE_DESCR                    VARCHAR(250)    NOT NULL COMMENT 'Name for the production shift type',
   SHIFT_START_TM                      TIME(9)         NOT NULL COMMENT 'The time represented as a timestamp of the format hh:mm_1:ss at which a specifc shift is starting.',
   SHIFT_END_TM                        TIME(9)         NOT NULL COMMENT 'The time represented as a timestamp of the format hh:mm_1:ss at which a specifc shift is ending.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_DIM_SHIFT PRIMARY KEY (SHIFT_ID) NOT ENFORCED
 )  COMMENT= 'Minor Dimension - with all possible shifts per production day. Source - MES via Proleit ODS (views on SQLServer delivered via Azure Data Factory). Table with all possible shifts per e.g. production day. The Schwarz Production divides its working day into different shifts, in which employees can be assigned to. Schwarz Produktion is producing its products in three shift operations';

