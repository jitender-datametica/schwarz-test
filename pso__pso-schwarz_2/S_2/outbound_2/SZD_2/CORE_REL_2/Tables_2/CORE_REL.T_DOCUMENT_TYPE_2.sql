/* --------------------------------------------------------------------------------
   DDL for table: T_DOCUMENT_TYPE_2
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:58:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_document_type_2 (
document_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the document type.'),
document_type_descr STRING(250) OPTIONS(description='A brief description of the document type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (document_type_cd) NOT ENFORCED
) OPTIONS(description='Minor Entity - Defines the possible types of documents. - Source - Manual');