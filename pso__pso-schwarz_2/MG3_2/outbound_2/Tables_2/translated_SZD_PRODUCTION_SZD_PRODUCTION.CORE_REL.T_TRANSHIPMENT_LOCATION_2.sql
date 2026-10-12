CREATE OR REPLACE TABLE szd_production_core_rel.t_transhipment_location_2 (
location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the transhipment location.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
transhipment_location_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the transhipment location_2 type.'),
port_price_group_cd STRING(50) NOT NULL OPTIONS(description='The code for the price group '),
country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_2 where the transhipment location_2 is located in.'),
transhipment_location_cd STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - The code of the transhipment location.'),
transhipment_location_name STRING(100) OPTIONS(description='The name of the transhipment location.'),
city_name STRING(100) OPTIONS(description='Name of the city in which site is situated'),
country_pol_cd STRING(3) OPTIONS(description='The code identifying a political country_2 according to ISO 3166.'),
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
OPTIONS(description='Major Entity - At a transhipment location_2 goods are unloaded from one transport vehicle like a ship and loaded into another transport vehicle like a train - Source - Manual');