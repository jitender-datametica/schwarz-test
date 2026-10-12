/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_ORGANIZATIONAL_REGION_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 30. November 2023 16:51:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_organizational_region_1 (
country_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for a country_1 according to ISO-3166 Alpha-2. E.g. DE for Germany or FR for France'),
zip_cd STRING(100) NOT NULL
OPTIONS(description='A zip code is a sequence of numbers or a combination of characters and numbers. It is part of a postal address_1 and designates the destination area.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
org_region_cd STRING(5) NOT NULL
OPTIONS(description='A two-letter code describing a sales_1 region_1 within a country. The regions are defined by Lidl Stiftung, and represent an organizational hierarchy_1 level within a country_1, from a sales_1 perspective.'),
org_region_descr STRING(250)
OPTIONS(description='A sales_1 region_1 within a country. The regions are defined by Lidl Stiftung, and represent an organizational hierarchy_1 level within a country_1, from a sales_1 perspective.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (dwh_valid_from_tmsp, country_cd, zip_cd) NOT ENFORCED
) OPTIONS(description='ETL table to support the loading of t_dim_organizational_region_1');