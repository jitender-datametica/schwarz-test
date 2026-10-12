CREATE OR REPLACE TABLE szd_production_etl.t_etl_ticket_division_country_business_rel_1 (
ticket_agreement_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the agreement ticket. Key generation based on META table for party key space.'),
affected_country_business_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location_1 as business country.It corresponds either to the business country_1 of the ticket caller (for Incident and Non Standard Request) or to the affected region_1(s) of a ticket Problem.If the callers region_1 is\\empty\\,the region_1 is that from the tickets First Assignment Group .Key generation based on META table for party key space. '),
affected_division_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. It corresponds either to the division of the ticket caller (for Incident and Non Standard Request) or to the affected divsion(s) of a ticket Problem. If the callers division is\\empty\\, the division  is that from the tickets First Assignment Group. Key generation based on META table for party key space.'),
assignment_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time, when the country_1 and division were assigned to this ticket..Only a ticket “Problem” can be assigned to several countries and divisions, and an assignment can be repeated during its lifecycle.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (ticket_agreement_sid, affected_country_business_location_sid, affected_division_party_sid, assignment_tmsp
 ) NOT ENFORCED
);