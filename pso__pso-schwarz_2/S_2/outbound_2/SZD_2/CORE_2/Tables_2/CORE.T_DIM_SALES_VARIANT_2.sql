/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_SALES_VARIANT_2
   generated from Powerdesigner on Mittwoch, 30. Juli 2025 09:40:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_sales_variant_2 (
product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
sales_variant_product_group_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the item_2 family.'),
sales_variant_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The business identifier of the sales_2 variant. This can be a article number from SAP or a sales_2 GTIN number.'),
sales_variant_name STRING(100) NOT NULL OPTIONS(description='The displayable name of the sales_2 variant.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source.'),
PRIMARY KEY (product_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - The sales_2 variants describes the kind of individual product, which is offered for sale. Variants of the same product may differ in their size (e.g. small, medium and large t-shirts), colour, style, flavour (e.g. strawberry and cherry yoghurt) or in certain technical details, such as a UK plug for a toaster. - Source - GTS, SAP RAN 900/878');