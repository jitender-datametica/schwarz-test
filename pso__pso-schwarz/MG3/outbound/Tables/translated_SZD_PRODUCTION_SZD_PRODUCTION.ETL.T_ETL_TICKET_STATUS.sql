CREATE OR REPLACE TABLE szd_production_etl.t_etl_ticket_status (
ticket_status_id INTEGER NOT NULL OPTIONS(description='The code identifying the discriminators for tickets status'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
ticket_type_id INTEGER NOT NULL
OPTIONS(description='The code identifying the discriminators for ticket types (Incident, NSR, Problem)'),
ticket_status_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the discriminators for tickets status'),
ticket_status_name STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for tickets status'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (ticket_status_id, lang_cd) NOT ENFORCED
);