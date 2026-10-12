/* --------------------------------------------------------------------------------
   DDL for table: T_COUNTRY_UNION
   generated from Powerdesigner on Donnerstag, 27. Juli 2023 09:23:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_country_union (
country_union_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the country union.'),
country_union_name STRING(100) NOT NULL OPTIONS(description='Descriptive Attribute - The name of the country union.'),
country_union_descr STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - A brief description of the country union.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (country_union_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - A union of countries is an association of different sovereign states for the purpose of close cooperation. - Source - Manual');