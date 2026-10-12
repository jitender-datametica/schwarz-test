/* --------------------------------------------------------------------------------
   DDL for table: T_IT_RESOURCE_TICKET_REL_TYPE
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_it_resource_ticket_rel_type (
it_resource_ticket_rel_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the discriminators for relation types between IT resources & tickets'),
it_resource_ticket_rel_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the discriminators for relation types between IT resources & tickets'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (it_resource_ticket_rel_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - table holds the relation types (affected or causative) of IT resources (application, solution etc.) to their assigned tickets.');