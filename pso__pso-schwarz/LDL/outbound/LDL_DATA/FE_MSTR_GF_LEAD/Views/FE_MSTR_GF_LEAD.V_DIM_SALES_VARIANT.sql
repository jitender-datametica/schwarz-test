CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_sales_variant (sales_variant_sid
OPTIONS(description='The unique identifier (surrogate key) for an sales variant of a product.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
sales_variant_nr OPTIONS(description='The number by which the sales variant is known to business.'), gtin
OPTIONS(description='The Global Trade Item Number (GTIN) that identifies this item variant.'), sales_variant_name
OPTIONS(description='The name of the product variant.'), prod_variant_status_cd
OPTIONS(description='A code that defines the lifecycle status of the sales variant,'), prod_variant_status_descr
OPTIONS(description='A textual description for the status code of a product variant in group language, i.e. in German.'),
sales_variant_type_cd OPTIONS(description='The code identifying the subtype discriminator for sales variants.'),
sales_variant_type_descr
OPTIONS(description='A textual description for the subtype discriminator for sales variants. (Description in group language, i.e. in German)'),
weight_based_fg OPTIONS(description='An indicator showing, if the product variant is sold by weight instead of count.'),
sales_variant_content_meas
OPTIONS(description='The content or size of the sales variant. E.g. 750ml. In case the sales variant consists of several units (e.g. 6 bottles with 1 liter each), this is the total content (i.e. 6 liters in this example). For weight-based products, this attribute is empty.'),
unit_cnt
OPTIONS(description='In case the sales variant consists of several units, this is the number of units, which are contained in the sales variant. E.g. for a pack of 6 bottles this is 6. For weight-based products, this attribute is empty.'),
unit_content_meas
OPTIONS(description='In case the sales variant consists of several units, this is the content or size of a single unit. E.g. for a pack of 6 bottles of 1 liter each, this is 1 liter. For weight-based products, this attribute is empty.'),
content_uom_cd OPTIONS(description='The code identifying the unit of measure, such as kg, meter or pieces.'),
non_food_variant_type_cd OPTIONS(description='The code identifying the subtype discriminator for non food variants.'),
non_food_variant_type_descr
OPTIONS(description='A textual description for the subtype discriminator for non food variants. (Description in group language, i.e. in German)'),
size_name OPTIONS(description='The name for the size of the sales variant. E.g. small / medium / large.'), style_name
OPTIONS(description='The name for the style of the sales variant, e.g. the color.'), kind_name
OPTIONS(description='The name of the local variation of the product, e.g. for the kind of plug (European vs. UK vs. US style of plugs) or of the kind of fruits or vegetables.'),
fruits_and_vegetables_class_cd OPTIONS(description='The code identifying the(quality) class for fruits and vegetables.'),
fruits_and_vegetables_class_descr
OPTIONS(description='A textual description for the (quality) class for fruits and vegetables. (Description in group language, i.e. in German)'),
min_caliber_meas OPTIONS(description='The minimum size (in the indicated unit of measure) for this caliber.'),
max_caliber_meas OPTIONS(description='The maximum size (in the indicated unit of measure) for this caliber.'),
caliber_uom_cd OPTIONS(description='The code identifying the unit of measure for the caliber.'), country_of_origin_cd
OPTIONS(description='The code identifying the country of origin of the sales variant, according to ISO 3166.'),
country_of_origin_name OPTIONS(description='The name of the country of origin of this sales variant.'), prod_sid
OPTIONS(description='The unique identifier (surrogate key) for the product, which is the base for this sales variant.'),
prod_nr
OPTIONS(description='The number which (globally) identifies the product which is the base for this sales variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re-used later on.)'),
prod_name OPTIONS(description='The name of the global product, which is the base for this sales variant.'), item_fam_sid
OPTIONS(description='The unique identifier (surrogate key) for the related item family, which contains this sales variant.'),
item_fam_nr OPTIONS(description='The number by which the related item family is known to business.'), item_fam_name
OPTIONS(description='The name of the item related family in group language, i.e. in German.'), sub_item_grp_sid
OPTIONS(description='The unique identifier (surrogate key) for the sub item group, which contains this sales variant.'),
sub_item_grp_nr OPTIONS(description='The number by which the related sub item group is known to business.'),
sub_item_grp_name OPTIONS(description='The name of the related sub item group in group language, i.e. in German.'),
int_item_grp_sid
OPTIONS(description='The unique identifier (surrogate key) for the international item group, which contains this sales variant.'),
int_item_grp_nr OPTIONS(description='The number by which the related international item group is known to business.'),
int_item_grp_name
OPTIONS(description='The name of the related international item group in group language, i.e. in German.'), pillar_sid
OPTIONS(description='The unique identifier (surrogate key) for the pillar, which contains this sales variant.'),
pillar_nr OPTIONS(description='The number by which the related pillar is known to business.'), pillar_name
OPTIONS(description='The name of the related pillar in group language, i.e. in German.'), main_pillar_sid
OPTIONS(description='The unique identifier (surrogate key) for the top pillar, which contains this sales variant.'),
main_pillar_nr OPTIONS(description='The number by which the related top pillar is known to business.'), main_pillar_name
OPTIONS(description='The name of the related top pillar in group language, i.e. in German.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')) AS
SELECT *
FROM ldl_data_core_dim.t_dim_sales_variant AS MAIN
WHERE dwh_valid_fg;