/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_DOCUMENT
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:53:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_customs_document (
resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item..'),
document_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the document type.'),
country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the political country.'),
usage_cd STRING(250) NOT NULL OPTIONS(description='The usage of this document (Import / Export / Both)'),
customs_document_cd STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - The code of the customs document. This is usually a 4 digit alphanumeric code.'),
customs_document_descr STRING(1000) OPTIONS(description='A brief description of what is this document about.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (resource_item_sid) NOT ENFORCED
)
OPTIONS(description='Major Entity - A customs document is used when handling with customs declarations and customs products. A customs document is usually attached to one or more products and also to a customs report line. - Source - Manual');