/* --------------------------------------------------------------------------------
   DDL for table: T_PRODUCT_2
   generated from Powerdesigner on Mittwoch, 2. April 2025 13:31:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_product_2 (
product_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
sales_variant_product_group_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unique idenfier (surrogate key) of the product group this product belongs to.'),
product_status_cd STRING(50) NOT NULL OPTIONS(description='The status_2 code for the product'),
product_division_type_cd STRING(50) NOT NULL
OPTIONS(description='Code for the type of product categorisation  ( TEX, HG )'),
ian_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural/Business Key -The business identifier of the product. Usually this is the IAN (International Article Number).'),
product_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute -The displayable name of the product. Cut at 100 characters if needed'),
product_name_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive attribute - Complete name of the product from the source'),
incoterm_name STRING(100)
OPTIONS(description='Descriptive attribute - Specific Incoterm that has been used and is also part of the contract of sale'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (product_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - The term "Product" describes goods and services which are offered by the enterprise. In the case of a retailer these are the goods the company trades with. The term "product" is not limited to the current assortment of goods and services., but may also include articles of competitors or articles which are currently not in the assortment. - Source - VMT, GTS, GS-Upload');