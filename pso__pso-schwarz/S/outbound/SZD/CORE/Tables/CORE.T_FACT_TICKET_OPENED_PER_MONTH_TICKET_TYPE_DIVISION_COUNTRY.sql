/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_TICKET_OPENED_PER_MONTH_TICKET_TYPE_DIVISION_COUNTRY
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_ticket_opened_per_month_ticket_type_division_country (
ticket_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the discriminators for ticket types.'),
cy_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar month as a number of the form YYYYMM, where YYYY is the calendar year and MM is month of the calendar year.'),
ticket_creator_country_business_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the business country (region in IT4You). Key generation based on META table for party key space.'),
ticket_creator_division_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.'),
ticket_type_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - A name for the discriminators for ticket types'),
ticket_creator_country_business_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name by which the business country of creator-user is known,'),
ticket_creator_division_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name by which the division of creator-user is known,'),
ticket_created_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - additive/aggregatable - tickets count of created tickets as last month snapshot.'),
ticket_opened_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - non additive/aggregatable - tickets count of opened tickets as last month snapshot. It means all tickets that were created before the end of  last month and the resolved date can still be empty or must be after the first of current month. In order to filter possible errors coming from the source system concerning INC and NSR tickets,  the status of such tickets must not be closed.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (ticket_type_id, cy_month, ticket_creator_country_business_location_sid, ticket_creator_division_party_sid)
NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by month & ticket type & users division & users country - Periodic Snapshot - contains aggregated status of completed (previous) month generated on the first of every month. Due to nature of a snapshot only the latest number of created and opened tickets from previous month will be taken in to account . - Source - IT4You Service Now.');