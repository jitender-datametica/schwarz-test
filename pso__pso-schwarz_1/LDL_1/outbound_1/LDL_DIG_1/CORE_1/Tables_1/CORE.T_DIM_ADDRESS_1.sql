/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_ADDRESS_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 30. November 2023 16:49:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_address_1 (
addr_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the addresses'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
addr_nr STRING(100) OPTIONS(description='Original addresses numbers in source system'),
addr_type_cd STRING(5)
OPTIONS(description='The code for the address_1 type. Possible values: OS (=OnlineShop) & TR (=Travel).'),
org_region_cd STRING(5)
OPTIONS(description='A two-letter code describing a sales_1 region_1 within a country. The regions are defined by Lidl Stiftung, and represent an organizational hierarchy_1 level within a country_1, from a sales_1 perspective.'),
zip_cd STRING(100)
OPTIONS(description='A zip code is a sequence of numbers or a combination of characters and numbers.'),
country_name STRING(100) OPTIONS(description='A country_1 name'),
city_name STRING(100) OPTIONS(description='The city name'),
street_name STRING(100)
OPTIONS(description='The name of a street, so that it can be distinguished from other streets. '),
house_nr STRING(100)
OPTIONS(description='A house number is a designation of a specific building in a street or a village.'),
district_name STRING(100) OPTIONS(description='A district name'),
post_box_nr STRING(100)
OPTIONS(description='A number of a box in a post office to which mail is delivered for the receipient to collect.'),
addr_suffix STRING(100) OPTIONS(description='Additional information for address_1 -  a floor , door number , etc'),
company_name STRING(100) OPTIONS(description='A company name used for delivery'),
addr_lon NUMERIC(9,6) OPTIONS(description='A geo longitude '),
addr_lat NUMERIC(9,6) OPTIONS(description='A geo latitude'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (addr_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='All possible street addresses,');