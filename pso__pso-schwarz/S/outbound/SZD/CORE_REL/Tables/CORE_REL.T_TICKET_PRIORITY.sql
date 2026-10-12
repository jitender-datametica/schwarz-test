/* --------------------------------------------------------------------------------
   DDL for table: T_TICKET_PRIORITY
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_ticket_priority (
ticket_priority_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code identifying the discriminators for tickets priority.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the unit (e.g. material unit, production line parameter)'),
ticket_priority_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code  identifying the discriminators for priority (e.g. Prio number for INC & PRB, urgency in days for NSR)'),
ticket_priority_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the discriminators for priority'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (ticket_priority_id, lang_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - defines the discriminators for priority like prio, urgency, precedency for any kind of objects e.g. tickets, contracts, events. Source - Source - IT4You Service Now');