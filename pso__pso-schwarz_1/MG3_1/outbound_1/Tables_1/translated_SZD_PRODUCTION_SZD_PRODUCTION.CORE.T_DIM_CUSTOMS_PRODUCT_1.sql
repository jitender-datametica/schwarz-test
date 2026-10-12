CREATE OR REPLACE TABLE szd_production_core.t_dim_customs_product_1 (
product_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the customs product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
sales_variant_product_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the item_1 family of this product.'),
customs_product_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the type of the customs_product_type.'),
customs_product_type_descr STRING(250) NOT NULL
OPTIONS(description='Denormalized Attribute - A brief description of the customs product type.'),
origin_country_location_sid INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique identifier (surrogate key) of the political country.'),
consignor_stream_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the type of the consignor stream.'),
origin_iso_country_cd STRING(50) NOT NULL
OPTIONS(description='Denormalized Attribute - The ISO code of the origin country.'),
origin_country_name_de STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The german name of the origin country.'),
origin_country_name_en STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The english name of the origin country.'),
customs_product_nr INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The product number of the customs product, depends on the customs product type.'),
customs_additional_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - An additional code to the product number (optional)'),
customs_classification_scheme_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the customs classification scheme.'),
customs_tariff_number_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the type of the customs tariff number.'),
customs_tariff_number_descr STRING(250)
OPTIONS(description='Descriptive Attribute - The name of the type of the customs tariff number.'),
food_nonfood_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the Food/Nonfood Type.'),
food_nonfood_type_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - The name of the Food/Nonfood Type.'),
alcoholic_beverage_tax_rate_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the alcoholic beverage tax rate.'),
alcoholic_beverage_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the Alcoholic Beverage Type.'),
alcoholic_beverage_type_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - The name of the Alcoholic Beverage Type.'),
alcoholic_beverage_volume_qty NUMERIC(29,5)
OPTIONS(description='The volume of the bottle/jar of the alcoholic beverage.'),
alcoholic_beverage_pct NUMERIC(29,5) OPTIONS(description='The percentage of alcohol within an alcoholic beverage.'),
alcoholic_beverage_duty_per_unit_val NUMERIC(29,5) OPTIONS(description='The amount of duty per unit_1 (bottle/jar).'),
customs_product_name STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - The name/descriptions of the customs product.'),
preferential_origin_fg BOOL
OPTIONS(description='Descriptive Attribute - Flag that shows whether the supplier_1 can provide proof of preference or not.'),
parent_product_sid INTEGER NOT NULL
OPTIONS(description='The product this customs product refers to (only applicable for WWT customs products).'),
parent_product_name STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - The name of product on IAN level.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (product_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - Contains the products in a granularity that the customs authorities can process, consisting of the product number (IAN), an additional optional product code, the customs tariff number and the country_1 of origin. - Source - GS-Upload, Broker Report');