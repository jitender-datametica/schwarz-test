CREATE OR REPLACE TABLE szd_production_core.t_dim_ticket_priority (
ticket_priority_id INTEGER NOT NULL OPTIONS(description='The code identifying the discriminators for tickets priority.'),
unit_id INTEGER NOT NULL OPTIONS(description='Id of the unit (e.g. material unit, production line parameter)'),
ticket_priority_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code  identifying the discriminators for priority (e.g. Prio number for INC & PRB, urgency in days for NSR)'),
ticket_priority_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the discriminators for priority'),
ticket_priority_descr_de STRING(250) NOT NULL
OPTIONS(description='A textual description for the discriminators for priority. Language german'),
ticket_priority_descr_en STRING(250) NOT NULL
OPTIONS(description='A textual description for the discriminators for priority. Language english'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (ticket_priority_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - defines the discriminators for priority like prio, urgency, precedency for any kind of objects e.g. tickets, contracts, events. Source - IT4You Service Now');