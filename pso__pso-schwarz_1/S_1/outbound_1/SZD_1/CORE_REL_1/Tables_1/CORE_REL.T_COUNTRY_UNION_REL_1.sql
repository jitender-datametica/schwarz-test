/* --------------------------------------------------------------------------------
   DDL for table: T_COUNTRY_UNION_REL_1
   generated from Powerdesigner on Donnerstag, 27. Juli 2023 09:35:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_country_union_rel_1 (
country_union_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the country_1 union.'),
country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique identifier (surrogate key) for the political country.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='An indicator showing the current record in history.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (country_union_cd, country_location_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Bridge Table - Defines the membership of political countries in country_1 unions. - Source - Manual');