/* --------------------------------------------------------------------------------
   DDL for table: T_SALES_VARIANT_2
   generated from Powerdesigner on Montag, 31. März 2025 09:51:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_sales_variant_2 (
product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
parent_product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product.'),
sales_variant_product_group_sid BIGNUMERIC(38,0)
OPTIONS(description='Major Entity - The sales_2 variant group is a special product group for sales_2 variants. - Source - LExIS'),
sales_variant_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The business identifier of the sales_2 variant. This can be a article number from SAP or a sales_2 GTIN number.'),
sales_variant_old_nr BIGNUMERIC(38,0)
OPTIONS(description='Descriptive attribute - the number of a former sales_2 variant that was replaced by this one'),
sales_variant_name STRING(100) NOT NULL OPTIONS(description='The displayable name of the sales_2 variant.'),
gtin_nr BIGNUMERIC(38,0) OPTIONS(description='Descriptive attribute - The GTIN of the sales_2 variant'),
base_quantity_unit_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Id of the unit_2 (e.g. material unit_2, production line parameter)'),
net_weight_meas BIGNUMERIC(38,5) OPTIONS(description='Descriptive attribute - the net weight of the sales_2 variant'),
net_weight_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the unit_2 of the net weight measure.'),
order_quantity_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the unit_2 of the order quantity.'),
size_txt STRING(1000) OPTIONS(description='Descriptive attribute - a text describing the size of the product'),
size_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the unit_2 of the size.'),
volume_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Id of the unit_2 of the volume.'),
business_valid_from_dt DATE
OPTIONS(description='Descriptive attribute - a date signifying from when on  sales_2 variant is considored valid by the business'),
earliest_delivery_dt DATE
OPTIONS(description='Descriptive attribute - the date when the sales_2 variant can be delivered at the earliest'),
internal_object_nr BIGNUMERIC(38,0)
OPTIONS(description='Descriptive attribute - an internal identifier from the source system'),
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
OPTIONS(description='Major Entity - The sales_2 variants describes the kind of individual product, which is offered for sale. Variants of the same product may differ in their size (e.g. small, medium and large t-shirts), colour, style, flavour (e.g. strawberry and cherry yoghurt) or in certain technical details, such as a UK plug for a toaster. - Source - GTS');