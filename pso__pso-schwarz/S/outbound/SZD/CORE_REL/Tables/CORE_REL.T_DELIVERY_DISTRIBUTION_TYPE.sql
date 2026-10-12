/* --------------------------------------------------------------------------------
   DDL for table: T_DELIVERY_DISTRIBUTION_TYPE
   generated from Powerdesigner on Donnerstag, 24. Juli 2025 13:53:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_delivery_distribution_type (
delivery_distribution_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the delivery distribution type code.'),
delivery_distribution_type_name STRING(100) NOT NULL
OPTIONS(description='The name of the delivery distribution type code.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source.'),
PRIMARY KEY (delivery_distribution_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Contains the possible types a delivery distributions can have. - Source - Manual.');