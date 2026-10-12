CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_product_variant_2 (
product_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant.'),
gtin_nr STRING(14) OPTIONS(description='GTIN for the variant of the product'),
int_product_nr STRING(20) OPTIONS(description='The number by which the product is known internationally.'),
int_product_name STRING(100) OPTIONS(description='The name by which the product is known internationally.'),
case_size_qty BIGNUMERIC(38,5) OPTIONS(description='Number of units that a logistic variant contains.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (product_variant_sid) NOT ENFORCED
)
OPTIONS(description='One product may have several variants. The information can be retrieved from the GTIN. For example ice cream (classic flavor, strawberry flavor etc.). ');