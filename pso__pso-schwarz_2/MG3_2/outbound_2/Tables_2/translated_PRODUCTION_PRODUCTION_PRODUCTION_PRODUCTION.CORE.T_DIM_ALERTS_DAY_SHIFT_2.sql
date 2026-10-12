CREATE OR REPLACE TABLE production_production_core.t_dim_alerts_day_shift_2 (
alerts_day_shift_id INTEGER NOT NULL
OPTIONS(description='Concatenated ID: alerts_day_shift_start_dt + alerts_shift_description_id as integer. Each day has 3 shifts.'),
alerts_day_shift_end_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
alerts_day_shift_start_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
alerts_shift_description_id INTEGER NOT NULL OPTIONS(description='The unique identifier for the shift description.'),
alerts_day_shift_start_tm TIME NOT NULL
OPTIONS(description='The time represented as a timestamp of the format hh:mm_2:ss at which a specifc shift is starting.'),
alerts_day_shift_end_tm TIME NOT NULL
OPTIONS(description='The time represented as a timestamp of the format hh:mm_2:ss at which a specifc shift is ending.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (alerts_day_shift_id) NOT ENFORCED
) OPTIONS(description='Dimension table with all possible shifts per production day.');