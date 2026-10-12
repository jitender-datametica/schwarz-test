CREATE OR REPLACE TABLE szd_production_core.t_dim_ticket_1 (
agreement_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the agreement ticket. Key generation based on META table for party key space.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
affected_it_resource_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item_1 as a affected IT ressource (CI). Key generation based on META table for party key space.'),
causative_it_resource_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item_1 as a causative IT ressource (CI). Key generation based on META table for party key space.'),
caller_business_unit_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a business unit. It defines the business unit_1 of the ticket caller.If the callers business unit_1 is "empty", the business unit_1 is that from the tickets First Assignment Group. Key generation based on META table for party key space.'),
affected_country_business_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location_1 as business country.It corresponds either to the business country_1 of the ticket caller (for Incident and Non Standard Request) or to the affected region_1(s) of a ticket Problem.If the callers region_1 is "empty",the region_1 is that from the tickets First Assignment Group. Key generation based on META table for party key space. '),
affected_division_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. It corresponds either to the division of the ticket caller (for Incident and Non Standard Request) or to the affected divsion(s) of a ticket Problem. If the callers division is "empty", the division is that from the tickets First Assignment Group. Key generation based on META table for party key space.'),
first_assignment_user_group_party_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party group as first assignment user group. Key generation based on META table for party key space.'),
resolving_user_group_party_group_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for the party group as resolving group. Key generation based on META table for party key space.'),
ticket_priority_id INTEGER NOT NULL OPTIONS(description='The code identifying the discriminators for tickets priority.'),
ticket_closing_reason_id INTEGER NOT NULL
OPTIONS(description='The code identifying the discriminators for ticket closing reasons'),
ticket_creation_method_type_id INTEGER NOT NULL
OPTIONS(description='The code identifying the discriminators for  ticket creation method type like Fullfiller or Enduserportal'),
parent_incident_agreement_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the agreement ticket of the master incident. Relation is only 1 Level'),
ticket_creation_dt DATE NOT NULL
OPTIONS(description='Ticket creation date - The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
ticket_creation_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Ticket creation timestamp - A point in time, identified by a date and a time component.'),
ticket_resolving_dt DATE
OPTIONS(description='Due date of ticket accordingly to the business definition - The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
ticket_resolving_tmsp TIMESTAMP
OPTIONS(description='Ticket resolved timestamp (for Incident and Problem) /  Ticket completed timestamp (for NSR)  accordingly to the business definition - A point in time, identified by a date and a time component.'),
ticket_closing_dt DATE
OPTIONS(description='Ticket closed date  - The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
ticket_closing_tmsp TIMESTAMP
OPTIONS(description='Ticket closed timestamp - A point in time, identified by a date and a time component.'),
ticket_type_id INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the discriminators for ticket types.'),
ticket_nr STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key -  Ticket Nummer (z.B. INC1234567) of a ticket created in e.g. IT4You.'),
ticket_descr STRING(250) NOT NULL OPTIONS(description='A textual description about the ticket.'),
ticket_active_fg BOOL NOT NULL
OPTIONS(description='Flag for ticket activity. TRUE - Ticket can be edited by the enduser. FALSE - Ticket cannot be edited by the enduser in IT4you.'),
master_incident_fg BOOL NOT NULL OPTIONS(description='Flag for indicating if the current incident is master incident'),
caller_business_unit_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The textual name of a business unit.'),
affected_country_business_cd STRING(3) NOT NULL
OPTIONS(description='Denormalized Attribute - The code identifying the country_1 according in the SCHWARZ group'),
affected_country_business_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name by which the country_1 is known,'),
affected_division_cd STRING(50) NOT NULL
OPTIONS(description='Denormalized Attribute - Natural/Business Key - The unique code for each division within the Schwarz Group, i.e.L-Lidl or K-Kaufland'),
affected_division_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name for the division within the Schwarz Group, i.e.Lidl or Kaufland'),
first_assignment_user_group_nr INTEGER NOT NULL
OPTIONS(description='Denormalized Attribute - Natural/Business Key - id of first assigned user group'),
first_assignment_user_group_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The group name by which the first assigned user group is identified on the system.'),
resolving_user_group_nr INTEGER
OPTIONS(description='Denormalized Attribute - Natural/Business Key - id of resolving user group'),
resolving_user_group_name STRING(100)
OPTIONS(description='Denormalized Attribute - The group name by which the resolving user group is identified on the system.'),
ticket_priority_descr STRING(250) NOT NULL
OPTIONS(description='Denormalized Attribute - A textual description for the discriminators for priority'),
ticket_closing_reason_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - A textual description for the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed successully, Declined'),
ticket_creation_method_type_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - A textual description for the discriminators for ticket creation method type'),
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
PRIMARY KEY (agreement_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - Ticket is physically stored technical object in a collaboration work system like Confluence, Azure DevOps, IT4You etc. with the special purpose to solve a problem, issue or fullfill a non standard request. Tickets are used to communicate between development teams, divisions & operational support teams. Source - IT4You ServiceNow');