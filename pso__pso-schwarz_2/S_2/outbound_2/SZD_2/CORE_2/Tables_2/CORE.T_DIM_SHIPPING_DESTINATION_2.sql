/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_SHIPPING_DESTINATION_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_shipping_destination_2 (
shipping_destination_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying a political country_2 according to ISO 3166.'),
shipping_destination_name STRING(100) NOT NULL
OPTIONS(description='The name for a political country_2 in group language, i.e. in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (shipping_destination_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - Shipping destination codes and their description in various languages. - Source - VMT');