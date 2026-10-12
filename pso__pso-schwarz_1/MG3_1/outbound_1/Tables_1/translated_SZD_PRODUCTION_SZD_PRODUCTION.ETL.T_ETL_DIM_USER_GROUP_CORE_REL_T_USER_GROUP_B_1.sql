CREATE OR REPLACE TABLE szd_production_etl.t_etl_dim_user_group_core_rel_t_user_group_b_1 (
party_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party group as user group. Key generation based on META table for party key space.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
org_unit_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party org unit. Key generation based on META table for party key space.'),
business_unit_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party business unit. Key generation based on META table for party key space.'),
country_business_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location_1 as a business country_1 .Key generation based on META table for party key space.'),
division_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division .Key generation based on META table for party key space.'),
user_group_nr INTEGER NOT NULL OPTIONS(description='Natural/Business Key - id of user group'),
user_group_name STRING(100) NOT NULL
OPTIONS(description='The group name by which the user group is identified on the system.'),
user_group_active_fg BOOL NOT NULL
OPTIONS(description='Flag for user validity. TRUE - User group is valid in IT4YOU. FALSE - User group is not valid anymore in IT4you.'),
int_org_unit_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The textual name of an organization unit_1'),
business_unit_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The textual name of a business unit_1'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (party_group_sid, dwh_valid_from_tmsp) NOT ENFORCED
);