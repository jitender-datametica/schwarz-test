CREATE OR REPLACE TABLE szd_production_core.t_fact_ticket_duration_per_month_ticket_type_division_country_2 (
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
OPTIONS(description='Denormalized Attribute - The name by which the country_2 is known,'),
ticket_duration_total_meas INTEGER NOT NULL
OPTIONS(description='Fact - non additive/aggregatable - tickets duration (in sec) defined as status_2 timestamp resolved - created as last month snapshot.'),
ticket_duration_unit_id INTEGER NOT NULL
OPTIONS(description='Id of the unit_2 (e.g. material unit_2, production line parameter) for all duration measures'),
ticket_avg_duration_meas INTEGER NOT NULL
OPTIONS(description='Fact - non additive/aggregatable - average duration of tickets (in sec) based on tables granularity - created as last month snapshot.'),
ticket_avg_duration_unit_id INTEGER NOT NULL
OPTIONS(description='Id of the unit_2 (e.g. material unit_2, production line parameter) for all average measures'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (ticket_type_id, cy_month, ticket_creator_country_business_location_sid, ticket_creator_division_party_sid)
NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by month & ticket type & current status_2 & users division & users business country_2 - Accumulating Snapshot_2 - contains ticket duration time of completed (previous) month generated on the first of every month.Contains NOT necessary every status_2 change of a ticket, Due to nature of a snapshot_2 only the latest status_2 (current status_2) of ticket will be exported from source system. So gaps in status_2 change chain are possible - Source - IT4You Service Now.');