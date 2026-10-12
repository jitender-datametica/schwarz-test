--==============================================================
-- Table: T_DIM_SHIFT
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_SHIFT
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:11 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_dim_shift (
shift_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Concatenated ID: shift_start_dt + shift_type_id as integer. Each day has 3 shifts.'),
shift_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier for the shift type.'),
shift_start_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
shift_end_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
shift_type_descr STRING(250) NOT NULL OPTIONS(description='Name for the production shift type'),
shift_start_tm TIME NOT NULL
OPTIONS(description='The time represented as a timestamp of the format hh:mm:ss at which a specifc shift is starting.'),
shift_end_tm TIME NOT NULL
OPTIONS(description='The time represented as a timestamp of the format hh:mm:ss at which a specifc shift is ending.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (shift_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - with all possible shifts per production day. Source - MES via Proleit ODS (views on SQLServer delivered via Azure Data Factory). Table with all possible shifts per e.g. production day. The Schwarz Production divides its working day into different shifts, in which employees can be assigned to. Schwarz Produktion is producing its products in three shift operations');