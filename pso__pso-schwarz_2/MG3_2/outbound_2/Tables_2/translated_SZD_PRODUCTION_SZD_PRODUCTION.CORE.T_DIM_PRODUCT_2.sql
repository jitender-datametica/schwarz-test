CREATE OR REPLACE TABLE szd_production_core.t_dim_product_2 (
product_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
product_status_cd STRING(50) NOT NULL OPTIONS(description='The status_2 code for the product'),
product_division_type_cd STRING(50) NOT NULL
OPTIONS(description='Code for the type of product categorisation  ( TEX, HG )'),
ian_nr INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The international article number (IAN) of the product.'),
product_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - The name of the product., cut at 100 characters if needed'),
product_name_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive Attribute - The complete name of the product from the source'),
incoterm_name STRING(100)
OPTIONS(description='Descriptive Attribute - Specific Incoterm that has been used and is also part of the contract of sale'),
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
OPTIONS(description='Major Dimension - Contains the products on the IAN level. - Source - GS Upload, Broker Report, VMT');