CREATE OR REPLACE TABLE production_production_core.t_fact_alerts_1 (
alerts_priority_id INTEGER NOT NULL
OPTIONS(description='The unique identifier for the alarm priorities (also containing inactive components)'),
alerts_message_id INTEGER NOT NULL
OPTIONS(description='The unique identifier for the alarm message which contains the information about the root cause '),
alerts_type_id INTEGER NOT NULL
OPTIONS(description='The unique identifiier for the alarm type which can be either manual or system'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
alerts_day_shift_id INTEGER NOT NULL OPTIONS(description='Concatenated ID (YYYYMMDDshiftID) as integer'),
alerts_location_id INTEGER NOT NULL
OPTIONS(description='The unique identifier for the alarm location_1 on which the alarm occured and where the station is located at.'),
alerts_tm TIME NOT NULL OPTIONS(description='The time represents the alarm time during a day (hh:mm_1:ss)'),
alerts_duration_diff INTEGER NOT NULL
OPTIONS(description='Precalculated duration of an alarm calculated the source system. Only populated on the\""off\"" message of an alarm.'),
alerts_production_stop_fg BOOL
OPTIONS(description='Flag for an alarm dataset pair, when this particular alarm caused an production stop. Will be filled by MSTR transaction service.'),
alerts_deleted_fg BOOL
OPTIONS(description='Flag for an manual alarm dataset pair, when it has been deleted by an user.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_load_id STRING(16777216) NOT NULL
OPTIONS(description='The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Transactional facts, capturing the system generated alarm messages.');