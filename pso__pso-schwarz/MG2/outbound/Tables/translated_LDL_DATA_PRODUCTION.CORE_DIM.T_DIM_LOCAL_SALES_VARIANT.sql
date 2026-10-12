CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_local_sales_variant (
sales_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the sales variant of a product.'),
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
local_sales_variant_nr STRING(100)
OPTIONS(description='The number which identifies the sales variant within the given market / internal organization.'),
local_sales_variant_name STRING(500)
OPTIONS(description='The name of the sales variant for the given market / internal organization.'),
prod_variant_status_cd STRING(20) NOT NULL
OPTIONS(description='A code that defines the lifecycle status of a product variant, i.e. of a sales variant or a logistc variant.'),
prod_variant_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the status code of a product variant in group language, i.e. in German.'),
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
prod_nr STRING(20)
OPTIONS(description='The number which (globally) identifies the product which is the base for this sales variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re-used later on.)'),
prod_name STRING(250) NOT NULL
OPTIONS(description='The name of the global product, which is the base for this sales variant.'),
item_fam_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the related item family.'),
item_fam_nr STRING(100) OPTIONS(description='The number by which the related item family is known to business.'),
item_fam_name STRING(100) NOT NULL
OPTIONS(description='The name of the related item family in group language, i.e. in German.'),
sub_item_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related sub item group'),
sub_item_grp_nr STRING(100) OPTIONS(description='The number by which the sub item group is known to business.'),
sub_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the related sub item group in group language, i.e. in German.'),
int_item_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier [surrogate key] for the related international item group.'),
int_item_grp_nr STRING(100)
OPTIONS(description='The number by which the related international item group is known to business.'),
int_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the related international item group in group language, i.e. in German.'),
pillar_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the related pillar.'),
pillar_nr STRING(100) OPTIONS(description='The number by which the related pillar is known to business.'),
pillar_name STRING(100) NOT NULL
OPTIONS(description='The name of the related pillar in group language, i.e. in German.'),
main_pillar_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related main pillar.'),
main_pillar_nr STRING(100) OPTIONS(description='The number by which the related main pillar is known to business.'),
main_pillar_name STRING(100) NOT NULL
OPTIONS(description='The name of the related main pillar in group language, i.e. in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (sales_variant_sid, dwh_valid_from_tmsp, country_org_sid) NOT ENFORCED
)
OPTIONS(description='This dimension tracks the local properties of each sales variant, as they are defined by a country organization.');