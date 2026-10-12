CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_logistic_variant_1 (logistic_variant_sid
OPTIONS(description='The unique identifier (surrogate key) for a logistic variant of a product.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
logistic_variant_nr OPTIONS(description='The number by which the logistic variant is known to business.'),
logistic_variant_name OPTIONS(description='The name of the logistic variant.'), logistic_variant_type_cd
OPTIONS(description='The code identifying the subtype discriminator for logistic variants.'),
logistic_variant_type_descr
OPTIONS(description='A textual description for the subtype discriminator for logistic variants. (Description in group language, i.e. in German)'),
prod_variant_status_cd OPTIONS(description='A code that defines the lifecycle status_1 of the logistic variant,'),
prod_variant_status_descr
OPTIONS(description='A textual description for the status_1 code of a product variant in group language, i.e. in German.'),
case_size_cnt
OPTIONS(description='The number of individual items that are contained in the logistic variant. (Note that the individual item_1 represents the smallest sellable unit. E.g. if a packed try of meat contains two slices, the entire tray is considered one sellable unit.)'),
weight_based_fg
OPTIONS(description='An indicator showing, if the product variant is delivered by weight instead of count.'),
length_meas OPTIONS(description='The length of the logistic variant, expressed in the indicated unit_1 of measure.'),
width_meas OPTIONS(description='The width of the logistic variant, expressed in the indicated unit_1 of measure.'),
height_meas OPTIONS(description='The height of the logistic variant, expressed in the indicated unit_1 of measure.'),
size_uom_cd OPTIONS(description='The code identifying the unit_1 of measure for the length, width and height.'),
net_weight_meas
OPTIONS(description='The net weight (i.e. excluding packing material) of the logistic variant, expressed in the indicated unit_1 of measure.'),
gross_weight_meas
OPTIONS(description='The gross weight (i.e. including packing material) of the logistic variant, expressed in the indicated unit_1 of measure.'),
weight_uom_cd OPTIONS(description='The code identifying the unit_1 of measure.'), units_per_pallet_cnt
OPTIONS(description='The number of logistic variants which can be packed on a pallet. (The type of pallet is indicated by the Pallet Type Code.)'),
units_per_pallet_layer_cnt
OPTIONS(description='The number of logistic variants which can be packed on one layer of a pallet. (The type of pallet is indicated by the Pallet Type Code.)'),
pallet_type_cd OPTIONS(description='The code identifying the kind of pallet. (Euro-pallet vs. Duesseldorfer pallet)'),
pallet_type_descr
OPTIONS(description='A textual description for the kind of pallet. (Description in group language, i.e. in German)'),
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
SELECT *
FROM ldl_data_core_dim.t_dim_logistic_variant_1 AS MAIN
WHERE dwh_valid_fg;