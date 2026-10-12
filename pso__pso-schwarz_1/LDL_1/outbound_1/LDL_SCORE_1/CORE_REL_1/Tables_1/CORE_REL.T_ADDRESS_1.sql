--==============================================================
-- Table: t_address_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_address_1
   generated from Powerdesigner on Donnerstag, 6. Juni 2024 09:38:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_address_1 (
addr_sid BIGNUMERIC NOT NULL OPTIONS(description='Is the unique identifier surrogate key of the address_1'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
country_cd STRING(2) OPTIONS(description='The code for the country_1 to which t_site_1 references on. '),
city_name STRING(100) OPTIONS(description='Name of the city'),
zip STRING(15) OPTIONS(description='Zip code / PLZ'),
street_name STRING(100) OPTIONS(description='Name of the street'),
longitude NUMERIC(9,6) OPTIONS(description='Object.address_1-data.coordinates x'),
latitude NUMERIC(9,6) OPTIONS(description='Object.address_1-data.coordinates y'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (addr_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='Table with Cargo adress informations');