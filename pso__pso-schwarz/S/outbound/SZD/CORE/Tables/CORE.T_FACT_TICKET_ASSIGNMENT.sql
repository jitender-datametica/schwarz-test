/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_TICKET_ASSIGNMENT
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_ticket_assignment (
ticket_agreement_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the agreement ticket. Key generation based on META table for party key space.'),
assignment_user_group_party_group_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party group as user group. Key generation based on META table for party key space.'),
prev_assignment_user_group_party_group_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party group as previous assignment group. Key generation based on META table for party key space.'),
ticket_assignment_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
ticket_assignment_tmsp TIMESTAMP NOT NULL
OPTIONS(description='A point in time, identified by a date and a time component.'),
ticket_assignment_day_of_week_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.'),
ticket_assignment_hr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The hour of day, i.e.a number in the range from 0 to 23.'),
ticket_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the discriminators for ticket types.'),
ticket_nr STRING(250) NOT NULL
OPTIONS(description='Denormalized Attribute - Natural/Business Key -  Ticket Nummer (z.B. INC1234567) of a ticket created in e.g. IT4You.'),
assignment_user_group_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Denormalized Attribute - Natural/Business Key - id of user group'),
assignment_user_group_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The group name by which the user group is identified on the system.'),
prev_assignment_user_group_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Denormalized Attribute - Natural/Business Key - id of user group'),
prev_assignment_user_group_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The group name by which the user group is identified on the system.'),
final_assignment_fg BOOL NOT NULL OPTIONS(description='Flag for designating if final assignement'),
fullfiller_delegated_fg BOOL NOT NULL
OPTIONS(description='Record is on TRUE if fullfiller creates a ticket & directly delegates it to another group in fullfiller ticket creation method.'),
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
PRIMARY KEY (ticket_agreement_sid, assignment_user_group_party_group_sid, prev_assignment_user_group_party_group_sid,
 ticket_assignment_tmsp) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional - Transaction - containing every assignement after ticket creation to an assignment group - Source - IT4You Service Now.');