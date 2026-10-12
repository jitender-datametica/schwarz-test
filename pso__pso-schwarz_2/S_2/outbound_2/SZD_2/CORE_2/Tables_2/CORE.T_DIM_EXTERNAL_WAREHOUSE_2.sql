/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_EXTERNAL_WAREHOUSE_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_external_warehouse_2 (
resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the warehouse.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
warehouse_name STRING(100) NOT NULL OPTIONS(description='Natural Key/Business Key - The name of the warehouse.'),
warehouse_short_name STRING(100)
OPTIONS(description='Descriptive Attribute - Short name of which the warehouse is known.'),
city_name STRING(100) OPTIONS(description='Descriptive Attribute - Name of the city in which warehouse is situated'),
country_pol_cd STRING(3) NOT NULL OPTIONS(description='The code identifying a political country_2 according to ISO 3166.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (resource_item_sid, dwh_valid_to_tmsp) NOT ENFORCED
) OPTIONS(description='Major Dimension - A  warehouse in the harbour used to unload and store goods. - Source VMT');