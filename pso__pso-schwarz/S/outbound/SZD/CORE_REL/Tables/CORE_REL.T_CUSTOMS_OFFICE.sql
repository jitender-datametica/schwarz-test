/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_OFFICE
   generated from Powerdesigner on Dienstag, 11. Juli 2023 14:30:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_customs_office (
party_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the customs office.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
authority_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique identifier (surrogate key) for the country where the customs office is located.'),
customs_office_cd STRING(250) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code that identifies the customs office within the country.'),
customs_office_name STRING(100) NOT NULL OPTIONS(description='Descriptive Attribute - The name of the customs office.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (party_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - A customs office is a department of a customs authority for the regulation of customs matters. - Source - Manual');