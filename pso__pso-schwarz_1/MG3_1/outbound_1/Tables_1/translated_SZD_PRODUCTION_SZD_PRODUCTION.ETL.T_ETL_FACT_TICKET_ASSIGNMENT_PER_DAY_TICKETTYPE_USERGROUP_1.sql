CREATE OR REPLACE TABLE szd_production_etl.t_etl_fact_ticket_assignment_per_day_tickettype_usergroup_1 (
assignment_user_group_party_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party group as user group. Key generation based on META table for party key space.'),
ticket_assignment_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
ticket_type_id INTEGER NOT NULL OPTIONS(description='The code identifying the discriminators for ticket types.'),
ticket_assignment_day_of_week_id INTEGER NOT NULL
OPTIONS(description='The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.'),
assignment_user_group_nr INTEGER NOT NULL
OPTIONS(description='Denormalized Attribute - Natural/Business Key - id of user group'),
assignment_user_group_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The group name by which the user group is identified on the system.'),
ticket_assignment_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive/aggregatable - ticket assignement count per per day / ticket type / user group'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (assignment_user_group_party_group_sid, ticket_assignment_dt, ticket_type_id) NOT ENFORCED
);