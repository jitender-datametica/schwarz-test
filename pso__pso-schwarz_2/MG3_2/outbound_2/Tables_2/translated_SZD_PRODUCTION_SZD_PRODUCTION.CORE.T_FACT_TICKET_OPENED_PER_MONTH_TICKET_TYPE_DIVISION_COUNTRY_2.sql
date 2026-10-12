CREATE OR REPLACE TABLE szd_production_core.t_fact_ticket_opened_per_month_ticket_type_division_country_2 (
ticket_type_id INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the discriminators for ticket types.'),
cy_month INTEGER NOT NULL
OPTIONS(description='The calendar_2 month as a number of the form YYYYMM, where YYYY is the calendar_2 year and MM_2 is month of the calendar_2 year.'),
ticket_creator_country_business_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the business country_2 (region_2 in IT4You). Key generation based on META table for party key space.'),
ticket_creator_division_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.'),
ticket_type_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - A name for the discriminators for ticket types'),
ticket_creator_country_business_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name by which the business country_2 of creator-user is known,'),
ticket_creator_division_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name by which the division of creator-user is known,'),
ticket_created_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive/aggregatable - tickets count of created tickets as last month snapshot.'),
ticket_opened_cnt INTEGER NOT NULL
OPTIONS(description='Fact - non additive/aggregatable - tickets count of opened tickets as last month snapshot. It means all tickets that were created before the end of  last month and the resolved date can still be empty or must be after the first of current month. In order to filter possible errors coming from the source system concerning INC and NSR tickets,  the status_2 of such tickets must not be closed.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (ticket_type_id, cy_month, ticket_creator_country_business_location_sid, ticket_creator_division_party_sid)
NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by month & ticket type & users division & users country_2 - Periodic Snapshot_2 - contains aggregated status_2 of completed (previous) month generated on the first of every month. Due to nature of a snapshot_2 only the latest number of created and opened tickets from previous month will be taken in to account_2 . - Source - IT4You Service Now.');