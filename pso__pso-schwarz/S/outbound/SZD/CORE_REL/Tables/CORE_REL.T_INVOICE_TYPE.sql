/* --------------------------------------------------------------------------------
   DDL for table: T_INVOICE_TYPE
   generated from Powerdesigner on Freitag, 9. Februar 2024 09:42:29
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_invoice_type (
invoice_type_cd STRING(50) NOT NULL OPTIONS(description='The unique type code of the invoice type.'),
invoice_type_name STRING(100) NOT NULL OPTIONS(description='A displayable name of the invoice type.'),
invoice_type_descr STRING(250) NOT NULL OPTIONS(description='A brief description of the invoice type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (invoice_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - The invoice type defines in what context was the invoice created. - Source - Manual');