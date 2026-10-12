/* --------------------------------------------------------------------------------
   DDL for table: T_INVOICE_STATUS_TYPE_2
   generated from Powerdesigner on Montag, 12. Februar 2024 08:43:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_invoice_status_type_2 (
invoice_status_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the invoice status_2 type.'),
invoice_status_type_name STRING(100) NOT NULL OPTIONS(description='The displayable name of the invoice status_2 type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (invoice_status_type_cd) NOT ENFORCED
) OPTIONS(description='Minor Entity - Defines the types of status_2 value an invoice can have. - Source - Manual');