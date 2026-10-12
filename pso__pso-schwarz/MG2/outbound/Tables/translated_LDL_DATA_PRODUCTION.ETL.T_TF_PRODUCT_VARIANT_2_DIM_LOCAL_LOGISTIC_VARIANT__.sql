CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_product_variant_2_dim_local_logistic_variant__ (
logistic_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a logistic variant of a product.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
local_logistic_variant_nr STRING(20)
OPTIONS(description='The number which identifies this logistic variant within the given market / internal organization.'),
local_logistic_variant_name STRING(500) NOT NULL
OPTIONS(description='The name of the logistic variant for the given market / internal organization.'),
prod_variant_status_cd STRING(20) NOT NULL
OPTIONS(description='A code that defines the lifecycle status of the logistic variant,'),
prod_variant_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the status code of a product variant in group language, i.e. in German.'),
prod_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product, which is the base for this logistic variant.'),
prod_nr STRING(20)
OPTIONS(description='The number which (globally) identifies the product which is the base for this logistic variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re-used later on.)'),
prod_name STRING(250) NOT NULL
OPTIONS(description='The name of the global product, which is the base for this logistic variant.'),
item_fam_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the item family, which contains this logistic variant.'),
item_fam_nr STRING(100) OPTIONS(description='The number by which the related item family is known to business.'),
item_fam_name STRING(100) NOT NULL
OPTIONS(description='The name of the related item family in group language, i.e. in German.'),
sub_item_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the sub item group, which contains this logistic variant.'),
sub_item_grp_nr STRING(100) OPTIONS(description='The number by which the related sub item group is known to business.'),
sub_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the related sub item group in group language, i.e. in German.'),
int_item_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the international item group, which contains this logistic variant.'),
int_item_grp_nr STRING(100)
OPTIONS(description='The number by which the related international item group is known to business.'),
int_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the related international item group in group language, i.e. in German.'),
pillar_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the pillar, which contains this logistic variant.'),
pillar_nr STRING(100) OPTIONS(description='The number by which the related pillar is known to business.'),
pillar_name STRING(100) NOT NULL
OPTIONS(description='The name of the related pillar in group language, i.e. in German.'),
main_pillar_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the main pillar, which contains this logistic variant.'),
main_pillar_nr STRING(100) OPTIONS(description='The number by which the related main pillar is known to business.'),
main_pillar_name STRING(100) NOT NULL
OPTIONS(description='The name of the related main pillar in group language, i.e. in German.'),
dwh_mapping_tmsp TIMESTAMP NOT NULL,
dwh_node_cd STRING(20) NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300),
dwh_load_id INTEGER,
filename STRING(1000) NOT NULL,
error_descr STRING(1000)
);