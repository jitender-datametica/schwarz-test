CREATE OR REPLACE TABLE szd_production_etl.t_etl_fact_ticket_status_tracking_resolving_per_month_ticket_type (
ticket_type_id INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the discriminators for ticket types.'),
cy_month INTEGER NOT NULL
OPTIONS(description='The calendar month as a number of the form YYYYMM, where YYYY is the calendar year and MM is month of the calendar year.'),
ticket_creator_country_business_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the business country (region in IT4You). Key generation based on META table for party key space.'),
ticket_creator_division_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.'),
ticket_solver_country_business_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location. Key generation based on META table for party key space.'),
ticket_solver_division_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.'),
ticket_type_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - A name for the discriminators for ticket types'),
ticket_creator_country_business_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name by which the business country of creator-user is known,'),
ticket_solver_country_business_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name by which the business country of solver-user is known,'),
ticket_resolved_cnt INTEGER NOT NULL
OPTIONS(description='Fact - non additive/aggregatable - tickets count of resolved tickets as last month snapshot'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (ticket_type_id, cy_month, ticket_creator_country_business_location_sid, ticket_creator_division_party_sid,
 ticket_solver_country_business_location_sid, ticket_solver_division_party_sid) NOT ENFORCED
);