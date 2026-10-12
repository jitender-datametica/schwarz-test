/* --------------------------------------------------------------------------------
   DDL for table: T_COUNTRY_BUSINESS_1
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_country_business_1 (
location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location. Key generation based on META table for party key space.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
country_group_location_group_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location_1 group'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
country_business_cd STRING(3) NOT NULL
OPTIONS(description='Natural/Business Key - The code identifying the country_1 according in the SCHWARZ group'),
country_business_iso3166_2_cd STRING(3) NOT NULL
OPTIONS(description='Descriptive Attribute - The code identifying the country_1 according to ISO 3166_2'),
country_business_iso3166_3_cd STRING(3) NOT NULL
OPTIONS(description='Descriptive Attribute - The code identifying the country_1 according to ISO 3166_3'),
country_business_name STRING(100) NOT NULL OPTIONS(description='The name by which the country_1 is known,'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (location_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - A SCHWARZ group country_1 used for internal usage. SCHWARZ group country_1 is different from common political country_1 entity e.g. it contains INT as country_1 definition. Source - IT4You Service Now');