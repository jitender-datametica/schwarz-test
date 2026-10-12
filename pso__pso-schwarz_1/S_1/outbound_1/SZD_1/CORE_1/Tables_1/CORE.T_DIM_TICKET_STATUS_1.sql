/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_TICKET_STATUS_1
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_ticket_status_1 (
ticket_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code identifying the discriminators for tickets status_1'),
ticket_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code identifying the discriminators for ticket types.'),
ticket_status_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the discriminators for tickets status_1'),
ticket_status_name STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for tickets status_1'),
ticket_status_name_en STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for tickets status. Language english'),
ticket_status_name_de STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for tickets status. Language german'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (ticket_status_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - defines the discriminators for tickets status. Possible status_1: Open / Work in progress / Waiting - wait for external oder wait for enduser / Comped / Closed. Source - IT4You Service Now');