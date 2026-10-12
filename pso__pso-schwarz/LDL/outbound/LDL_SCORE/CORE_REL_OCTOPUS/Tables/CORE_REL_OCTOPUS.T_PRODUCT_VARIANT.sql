CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_product_variant (
product_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
product_variant_type_cd STRING(20) OPTIONS(description='The code for the type of the product variant e.g. LOG'),
product_variant_status_cd STRING(20) OPTIONS(description='The code for the status of the product variant.'),
gtin_nr STRING(14)
OPTIONS(description='The Global Trade Item Number (GTIN) is an identifier for trade items, developed by GS1. It identifies single product variants and/or logistic variants.'),
int_product_nr STRING(20) OPTIONS(description='The number by which the product is known internationally.'),
int_product_name STRING(100) OPTIONS(description='The name by which the product is known internationally.'),
uom_cd STRING(20) OPTIONS(description='A code for the unit of measure associated with the package quantity.'),
packaging_cd STRING(20) OPTIONS(description='A code for the packaging.'),
package_qty BIGNUMERIC(38,5) OPTIONS(description='The quantity that is in a single package.'),
case_size_qty BIGNUMERIC OPTIONS(description='Number of units that a logistic variant contains.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
PRIMARY KEY (product_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This entity contains all product variants related to a product that are purchased and/or sold.             It is either a logistic variant that is typically transported and/or a style variant.');