CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_local_logistic_variant (logistic_variant_sid
OPTIONS(description='The unique identifier (surrogate key) for a logistic variant of a product.'), country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the country organization.'), country_org_cd
OPTIONS(description='The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)'),
dwh_valid_from_tmsp OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
local_logistic_variant_nr
OPTIONS(description='The number which identifies this logistic variant within the given market / internal organization.'),
local_logistic_variant_name
OPTIONS(description='The name of the logistic variant for the given market / internal organization.'),
prod_variant_status_cd OPTIONS(description='A code that defines the lifecycle status of the logistic variant,'),
prod_variant_status_descr
OPTIONS(description='A textual description for the status code of a product variant in group language, i.e. in German.'),
prod_sid
OPTIONS(description='The unique identifier (surrogate key) for the product, which is the base for this logistic variant.'),
prod_nr
OPTIONS(description='The number which (globally) identifies the product which is the base for this logistic variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re-used later on.)'),
prod_name OPTIONS(description='The name of the global product, which is the base for this logistic variant.'),
item_fam_sid
OPTIONS(description='The unique identifier (surrogate key) for the item family, which contains this logistic variant.'),
item_fam_nr OPTIONS(description='The number by which the related item family is known to business.'), item_fam_name
OPTIONS(description='The name of the related item family in group language, i.e. in German.'), sub_item_grp_sid
OPTIONS(description='The unique identifier (surrogate key) for the sub item group, which contains this logistic variant.'),
sub_item_grp_nr OPTIONS(description='The number by which the related sub item group is known to business.'),
sub_item_grp_name OPTIONS(description='The name of the related sub item group in group language, i.e. in German.'),
int_item_grp_sid
OPTIONS(description='The unique identifier (surrogate key) for the international item group, which contains this logistic variant.'),
int_item_grp_nr OPTIONS(description='The number by which the related international item group is known to business.'),
int_item_grp_name
OPTIONS(description='The name of the related international item group in group language, i.e. in German.'), pillar_sid
OPTIONS(description='The unique identifier (surrogate key) for the pillar, which contains this logistic variant.'),
pillar_nr OPTIONS(description='The number by which the related pillar is known to business.'), pillar_name
OPTIONS(description='The name of the related pillar in group language, i.e. in German.'), main_pillar_sid
OPTIONS(description='The unique identifier (surrogate key) for the main pillar, which contains this logistic variant.'),
main_pillar_nr OPTIONS(description='The number by which the related main pillar is known to business.'),
main_pillar_name OPTIONS(description='The name of the related main pillar in group language, i.e. in German.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')) AS
SELECT *
FROM ldl_data_core_dim.t_dim_local_logistic_variant AS MAIN
WHERE dwh_valid_fg;