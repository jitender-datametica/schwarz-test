CREATE OR REPLACE TABLE szd_production_core_rel.t_ticket_type (
ticket_type_id INTEGER NOT NULL
OPTIONS(description='The code identifying the discriminators for ticket types (Incident, NSR, Problem)'),
ticket_type_name STRING(100) NOT NULL OPTIONS(description='A textual name for the discriminators for ticket types'),
synonym_ticket_type_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - The synonym name of the ticket specified for IT4You.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (ticket_type_id) NOT ENFORCED
)
OPTIONS(description='Minor Entity - entity defines the discriminators for tickets (INC, NSR, PRB). Source - based on IT4You Service Now');