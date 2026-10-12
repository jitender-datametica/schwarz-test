CREATE OR REPLACE TABLE szd_production_core_rel.t_internal_organizational_unit_rel_1 (
child_internal_org_unit_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
parent_internal_org_unit_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (child_internal_org_unit_party_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This relation table holds the internal organizational units under Schwarz Group and their child units.- Source - IT4You ServiceNow');