/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_TICKET_STATUS_TRACKING_RESOLVING_PER_MONTH_TICKET_TYPE_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_ticket_status_tracking_resolving_per_month_ticket_type_2 (
ticket_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the discriminators for ticket types.'),
cy_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_2 month as a number of the form YYYYMM, where YYYY is the calendar_2 year and MM_2 is month of the calendar_2 year.'),
ticket_creator_country_business_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the business country_2 (region_2 in IT4You). Key generation based on META table for party key space.'),
ticket_creator_division_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.'),
ticket_solver_country_business_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location. Key generation based on META table for party key space.'),
ticket_solver_division_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.'),
ticket_type_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - A name for the discriminators for ticket types'),
ticket_creator_country_business_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name by which the business country_2 of creator-user is known,'),
ticket_solver_country_business_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name by which the business country_2 of solver-user is known,'),
ticket_resolved_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - non additive/aggregatable - tickets count of resolved tickets as last month snapshot_2'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (ticket_type_id, cy_month, ticket_creator_country_business_location_sid, ticket_creator_division_party_sid,
 ticket_solver_country_business_location_sid, ticket_solver_division_party_sid) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by month & ticket type  & users division & users country_2 - Accumulating Snapshot_2 - contains aggregated status_2 of completed (previous) month generated on the first of every month.Contains NOT necessary every status_2 change of a ticket, Due to nature of a snapshot_2 only the latest status_2 (current status_2) of ticket will be exported from source system. So gaps in status_2 change chain are possible - Source - IT4You Service Now.');