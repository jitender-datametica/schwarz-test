CREATE OR REPLACE TABLE szd_production_etl.t_etl_ticket_incident_problem_incident_b_2 (
agreement_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the agreement ticket. Key generation based on META table for party key space.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
caller_business_unit_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a business unit. It defines the business unit_2 of the ticket caller.If the callers business unit_2 is empty, the business unit_2 is that from the tickets First Assignment Group. Key generation based on META table for party key space.'),
first_assignment_user_group_party_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party group as first assignment user group. Key generation based on META table for party key space.'),
resolving_user_group_party_group_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for the party group as resolving group. Key generation based on META table for party key space.'),
ticket_priority_id INTEGER NOT NULL OPTIONS(description='The code identifying the discriminators for tickets priority.'),
ticket_closing_reason_id INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the discriminators for ticket closing reasons'),
parent_incident_agreement_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the agreement ticket of the master incident. Relation is only 1 Level'),
ticket_creation_dt DATE NOT NULL
OPTIONS(description='Ticket creation date - The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
ticket_creation_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Ticket creation timestamp - A point in time, identified by a date and a time component.'),
ticket_resolving_dt DATE
OPTIONS(description='Ticket resolved date (for Incident and Problem) /  Ticket completed date (for NSR)  accordingly to the business definition - The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
ticket_resolving_tmsp TIMESTAMP
OPTIONS(description='Ticket resolved timestamp (for Incident and Problem) /  Ticket completed timestamp (for NSR)  accordingly to the business definition - A point in time, identified by a date and a time component.'),
ticket_creation_method_type_id INTEGER NOT NULL
OPTIONS(description='The code identifying the discriminators for  ticket creation method type like Fullfiller or Enduserportal'),
ticket_type_id INTEGER NOT NULL
OPTIONS(description='The code identifying the discriminators for ticket types (Incident, NSR, Problem)'),
ticket_nr STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key -  Ticket Nummer (z.B. INC1234567) of a ticket created in e.g. IT4You.'),
ticket_descr STRING(250) NOT NULL OPTIONS(description='A textual description about the ticket.'),
ticket_active_fg BOOL NOT NULL
OPTIONS(description='Flag for ticket activity. TRUE - Ticket can be edited by the enduser. FALSE - Ticket cannot be edited by the enduser in IT4you.'),
master_incident_fg BOOL NOT NULL OPTIONS(description='Flag for indicating if the current incident is master incident'),
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
ticket_closing_dt DATE
OPTIONS(description='Ticket closed date  - The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
ticket_closing_tmsp TIMESTAMP
OPTIONS(description='Ticket closed timestamp - A point in time, identified by a date and a time component.'),
PRIMARY KEY (agreement_sid, dwh_valid_from_tmsp) NOT ENFORCED
);