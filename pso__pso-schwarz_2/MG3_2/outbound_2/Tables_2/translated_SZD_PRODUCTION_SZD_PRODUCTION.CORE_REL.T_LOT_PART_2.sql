CREATE OR REPLACE TABLE szd_production_core_rel.t_lot_part_2 (
product_instance_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the lot part.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
lot_part_status_cd STRING(50) NOT NULL OPTIONS(description='The status_2 code for the lot part'),
lot_product_instance_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the lot.'),
shipping_destination_cd STRING(50) NOT NULL
OPTIONS(description='The code identifying a political country_2 according to ISO 3166.'),
gtin_nr STRING(50) OPTIONS(description='Descriptive Attribute - GTIN'),
spare_unit_fg BOOL NOT NULL OPTIONS(description='Descriptive Attribute - Indication if spare unit_2 or not'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (product_instance_group_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='Major Entity - A shipment of particular product variant  - Source - VMT');