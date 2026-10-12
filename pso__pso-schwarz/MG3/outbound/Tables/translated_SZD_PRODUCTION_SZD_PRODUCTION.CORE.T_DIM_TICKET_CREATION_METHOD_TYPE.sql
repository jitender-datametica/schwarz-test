CREATE OR REPLACE TABLE szd_production_core.t_dim_ticket_creation_method_type (
ticket_creation_method_type_id INTEGER NOT NULL
OPTIONS(description='The code identifying the discriminators for  ticket creation method type like Fullfiller or Enduserportal'),
ticket_type_id INTEGER NOT NULL OPTIONS(description='The code identifying the discriminators for ticket types.'),
ticket_creation_method_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the discriminators for  ticket creation method type like Fullfiller or Enduserportal'),
ticket_creation_method_type_name STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for ticket creation method type'),
ticket_creation_method_type_name_de STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for ticket creation method type. Language german'),
ticket_creation_method_type_name_en STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for ticket creation method type. Language english'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (ticket_creation_method_type_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - defines the discriminators for ticket creation method type like Fullfiller or Enduserportal. Source - Manually filled');