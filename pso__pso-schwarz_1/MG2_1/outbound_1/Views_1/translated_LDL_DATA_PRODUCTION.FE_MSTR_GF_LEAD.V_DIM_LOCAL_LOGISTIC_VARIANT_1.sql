CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_dim_local_logistic_variant_1 (logistic_variant_sid
OPTIONS(description='The unique identifier (surrogate key) for a logistic variant of a product.'), country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the country_1 organization.'), country_org_cd
OPTIONS(description='The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)'),
dwh_valid_from_tmsp OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
local_logistic_variant_nr
OPTIONS(description='The number which identifies this logistic variant within the given market / internal organization.'),
local_logistic_variant_name
OPTIONS(description='The name of the logistic variant for the given market / internal organization.'),
prod_variant_status_cd OPTIONS(description='A code that defines the lifecycle status_1 of the logistic variant,'),
prod_variant_status_descr
OPTIONS(description='A textual description for the status_1 code of a product variant in group language, i.e. in German.'),
prod_sid
OPTIONS(description='The unique identifier (surrogate key) for the product, which is the base for this logistic variant.'),
prod_nr
OPTIONS(description='The number which (globally) identifies the product which is the base for this logistic variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re_1-used later on.)'),
prod_name OPTIONS(description='The name of the global product, which is the base for this logistic variant.'),
item_fam_sid
OPTIONS(description='The unique identifier (surrogate key) for the item_1 family, which contains this logistic variant.'),
item_fam_nr OPTIONS(description='The number by which the related item_1 family is known to business.'), item_fam_name
OPTIONS(description='The name of the related item_1 family in group language, i.e. in German.'), sub_item_grp_sid
OPTIONS(description='The unique identifier (surrogate key) for the sub item_1 group, which contains this logistic variant.'),
sub_item_grp_nr OPTIONS(description='The number by which the related sub item_1 group is known to business.'),
sub_item_grp_name OPTIONS(description='The name of the related sub item_1 group in group language, i.e. in German.'),
int_item_grp_sid
OPTIONS(description='The unique identifier (surrogate key) for the international item_1 group, which contains this logistic variant.'),
int_item_grp_nr OPTIONS(description='The number by which the related international item_1 group is known to business.'),
int_item_grp_name
OPTIONS(description='The name of the related international item_1 group in group language, i.e. in German.'), pillar_sid
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
SELECT logistic_variant_sid,
 country_org_sid,
 country_org_cd,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 local_logistic_variant_nr,
 local_logistic_variant_name,
 prod_variant_status_cd,
 prod_variant_status_descr,
 prod_sid,
 prod_nr,
 prod_name,
 item_fam_sid,
 item_fam_nr,
 item_fam_name,
 sub_item_grp_sid,
 sub_item_grp_nr,
 sub_item_grp_name,
 int_item_grp_sid,
 int_item_grp_nr,
 int_item_grp_name,
 pillar_sid,
 pillar_nr,
 pillar_name,
 main_pillar_sid,
 main_pillar_nr,
 main_pillar_name,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_local_logistic_variant_1 AS main
WHERE dwh_valid_fg;