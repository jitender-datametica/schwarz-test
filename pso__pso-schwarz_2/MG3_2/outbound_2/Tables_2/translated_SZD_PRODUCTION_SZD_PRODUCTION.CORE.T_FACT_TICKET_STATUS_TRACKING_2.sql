CREATE OR REPLACE TABLE szd_production_core.t_fact_ticket_status_tracking_2 (
ticket_agreement_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the agreement ticket. Key generation based on META table for party key space.'),
user_group_party_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party group as user group. Key generation based on META table for party key space.'),
ticket_status_id INTEGER NOT NULL OPTIONS(description='The code identifying the discriminators for tickets status_2'),
status_change_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
status_change_tmsp TIMESTAMP NOT NULL
OPTIONS(description='A point in time, identified by a date and a time component.'),
status_change_day_of_week_id INTEGER NOT NULL
OPTIONS(description='The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.'),
status_change_hr_id INTEGER NOT NULL OPTIONS(description='The hour of day, i.e.a number in the range from 0 to 23.'),
user_division_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division of the user who is status_2 changer. Key generation based on META table for party key space.'),
user_country_business_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location_2 as a country_2 of the user who is status_2 changer. Key generation based on META table for party key space.'),
ticket_nr STRING(250) NOT NULL
OPTIONS(description='Denormalized Attribute - Natural/Business Key -  Ticket Nummer (z.B. INC1234567) of a ticket created in e.g. IT4You.'),
assigned_user_group_nr INTEGER NOT NULL
OPTIONS(description='Denormalized Attribute - Natural/Business Key - id of user group'),
assigned_user_group_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The group name by which the user group is identified on the system.'),
source_sys_nr STRING(100) NOT NULL
OPTIONS(description='Source system payload attribute - Technical Surrogate Key (surves as Natural Key) - additional technical system id for identification of tickets.'),
source_updated_on_tmsp TIMESTAMP
OPTIONS(description='Source system payload attribute - The point in time when this record was last modified in the source system. (In case the record has not been modified since its creation, source_updated_on is identical to creation timestamp)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (ticket_agreement_sid, user_group_party_group_sid, ticket_status_id, status_change_tmsp) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional -Permuted  Periodic Snapshot_2 - containing NOT necessary every status_2 change of a ticket, Due to nature of a snapshot_2 only the latest status_2 of ticket will be exported from source system. So gaps in status_2 change chain are possible. These gaps are artificially filled in the DWH day after day if a ticket has not undergone a status_2 change on that day. This means that the last status_2 can be more than 1 day in the past - Source - IT4You Service Now.');