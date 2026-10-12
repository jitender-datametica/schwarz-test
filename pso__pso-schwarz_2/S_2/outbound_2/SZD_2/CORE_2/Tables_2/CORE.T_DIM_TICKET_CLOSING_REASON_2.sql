/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_TICKET_CLOSING_REASON_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_ticket_closing_reason_2 (
ticket_closing_reason_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code identifying the discriminators for ticket closing reasons'),
ticket_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code identifying the discriminators for ticket types.'),
ticket_closing_reason_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - A code for the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed successully, Declined, CBBC for Rückruf vor Abschluss. In some cases also numbered codes'),
ticket_closing_reason_name STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed successully, Declined'),
ticket_closing_reason_name_en STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed successully, Declined'),
ticket_closing_reason_name_de STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed successully, Declined'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (ticket_closing_reason_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - defines the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed, successully Declined             Source - IT4You Service Now');