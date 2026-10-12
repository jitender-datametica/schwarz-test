CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_DIM_SALES_VARIANT_1(
	sales_variant_sid COMMENT 'The unique identifier (surrogate key) for an sales_1 variant of a product.',
	dwh_valid_from_tmsp COMMENT 'The point in time when this record became valid.',
	dwh_valid_to_tmsp COMMENT 'The point in time when this record was no longer valid.',
	dwh_valid_fg COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	sales_variant_nr COMMENT 'The number by which the sales_1 variant is known to business.',
	gtin COMMENT 'The Global Trade Item_1 Number (GTIN) that identifies this item_1 variant.',
	sales_variant_name COMMENT 'The name of the product variant.',
	prod_variant_status_cd COMMENT 'A code that defines the lifecycle status_1 of the sales_1 variant,',
	prod_variant_status_descr COMMENT 'A textual description for the status_1 code of a product variant in group language, i.e. in German.',
	sales_variant_type_cd COMMENT 'The code identifying the subtype discriminator for sales_1 variants.',
	sales_variant_type_descr COMMENT 'A textual description for the subtype discriminator for sales_1 variants. (Description in group language, i.e. in German)',
	weight_based_fg COMMENT 'An indicator showing, if the product variant is sold by weight instead of count.',
	sales_variant_content_meas COMMENT 'The content or size of the sales_1 variant. E.g. 750ml. In case the sales_1 variant consists of several units (e.g. 6 bottles with 1 liter each), this is the total content (i.e. 6 liters in this example). For weight-based products, this attribute is empty.',
	unit_cnt COMMENT 'In case the sales_1 variant consists of several units, this is the number of units, which are contained in the sales_1 variant. E.g. for a pack of 6 bottles this is 6. For weight-based products, this attribute is empty.',
	unit_content_meas COMMENT 'In case the sales_1 variant consists of several units, this is the content or size of a single unit. E.g. for a pack of 6 bottles of 1 liter each, this is 1 liter. For weight-based products, this attribute is empty.',
	content_uom_cd COMMENT 'The code identifying the unit_1 of measure, such as kg, meter or pieces.',
	non_food_variant_type_cd COMMENT 'The code identifying the subtype discriminator for non food variants.',
	non_food_variant_type_descr COMMENT 'A textual description for the subtype discriminator for non food variants. (Description in group language, i.e. in German)',
	size_name COMMENT 'The name for the size of the sales_1 variant. E.g. small / medium / large.',
	style_name COMMENT 'The name for the style of the sales_1 variant, e.g. the color.',
	kind_name COMMENT 'The name of the local variation of the product, e.g. for the kind of plug (European vs. UK vs. US style of plugs) or of the kind of fruits or vegetables.',
	fruits_and_vegetables_class_cd COMMENT 'The code identifying the(quality) class for fruits and vegetables.',
	fruits_and_vegetables_class_descr COMMENT 'A textual description for the (quality) class for fruits and vegetables. (Description in group language, i.e. in German)',
	min_caliber_meas COMMENT 'The minimum size (in the indicated unit_1 of measure) for this caliber.',
	max_caliber_meas COMMENT 'The maximum size (in the indicated unit_1 of measure) for this caliber.',
	caliber_uom_cd COMMENT 'The code identifying the unit_1 of measure for the caliber.',
	country_of_origin_cd COMMENT 'The code identifying the country_1 of origin of the sales_1 variant, according to ISO 3166.',
	country_of_origin_name COMMENT 'The name of the country_1 of origin of this sales_1 variant.',
	prod_sid COMMENT 'The unique identifier (surrogate key) for the product, which is the base for this sales_1 variant.',
	prod_nr COMMENT 'The number which (globally) identifies the product which is the base for this sales_1 variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re_1-used later on.)',
	prod_name COMMENT 'The name of the global product, which is the base for this sales_1 variant.',
	item_fam_sid COMMENT 'The unique identifier (surrogate key) for the related item_1 family, which contains this sales_1 variant.',
	item_fam_nr COMMENT 'The number by which the related item_1 family is known to business.',
	item_fam_name COMMENT 'The name of the item_1 related family in group language, i.e. in German.',
	sub_item_grp_sid COMMENT 'The unique identifier (surrogate key) for the sub item_1 group, which contains this sales_1 variant.',
	sub_item_grp_nr COMMENT 'The number by which the related sub item_1 group is known to business.',
	sub_item_grp_name COMMENT 'The name of the related sub item_1 group in group language, i.e. in German.',
	int_item_grp_sid COMMENT 'The unique identifier (surrogate key) for the international item_1 group, which contains this sales_1 variant.',
	int_item_grp_nr COMMENT 'The number by which the related international item_1 group is known to business.',
	int_item_grp_name COMMENT 'The name of the related international item_1 group in group language, i.e. in German.',
	pillar_sid COMMENT 'The unique identifier (surrogate key) for the pillar, which contains this sales_1 variant.',
	pillar_nr COMMENT 'The number by which the related pillar is known to business.',
	pillar_name COMMENT 'The name of the related pillar in group language, i.e. in German.',
	main_pillar_sid COMMENT 'The unique identifier (surrogate key) for the top pillar, which contains this sales_1 variant.',
	main_pillar_nr COMMENT 'The number by which the related top pillar is known to business.',
	main_pillar_name COMMENT 'The name of the related top pillar in group language, i.e. in German.',
	dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.',
	dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.',
	dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) AS SELECT
  main.sales_variant_sid AS sales_variant_sid
, main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
, main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
, main.dwh_valid_fg AS dwh_valid_fg
, main.sales_variant_nr AS sales_variant_nr
, main.gtin AS gtin
, main.sales_variant_name AS sales_variant_name
, main.prod_variant_status_cd AS prod_variant_status_cd
, main.prod_variant_status_descr AS prod_variant_status_descr
, main.sales_variant_type_cd AS sales_variant_type_cd
, main.sales_variant_type_descr AS sales_variant_type_descr
, main.weight_based_fg AS weight_based_fg
, main.sales_variant_content_meas AS sales_variant_content_meas
, main.unit_cnt AS unit_cnt
, main.unit_content_meas AS unit_content_meas
, main.content_uom_cd AS content_uom_cd
, main.non_food_variant_type_cd AS non_food_variant_type_cd
, main.non_food_variant_type_descr AS non_food_variant_type_descr
, main.size_name AS size_name
, main.style_name AS style_name
, main.kind_name AS kind_name
, main.fruits_and_vegetables_class_cd AS fruits_and_vegetables_class_cd
, main.fruits_and_vegetables_class_descr AS fruits_and_vegetables_class_descr
, main.min_caliber_meas AS min_caliber_meas
, main.max_caliber_meas AS max_caliber_meas
, main.caliber_uom_cd AS caliber_uom_cd
, main.country_of_origin_cd AS country_of_origin_cd
, main.country_of_origin_name AS country_of_origin_name
, main.prod_sid AS prod_sid
, main.prod_nr AS prod_nr
, main.prod_name AS prod_name
, main.item_fam_sid AS item_fam_sid
, main.item_fam_nr AS item_fam_nr
, main.item_fam_name AS item_fam_name
, main.sub_item_grp_sid AS sub_item_grp_sid
, main.sub_item_grp_nr AS sub_item_grp_nr
, main.sub_item_grp_name AS sub_item_grp_name
, main.int_item_grp_sid AS int_item_grp_sid
, main.int_item_grp_nr AS int_item_grp_nr
, main.int_item_grp_name AS int_item_grp_name
, main.pillar_sid AS pillar_sid
, main.pillar_nr AS pillar_nr
, main.pillar_name AS pillar_name
, main.main_pillar_sid AS main_pillar_sid
, main.main_pillar_nr AS main_pillar_nr
, main.main_pillar_name AS main_pillar_name
, main.dwh_created_tmsp AS dwh_created_tmsp
, main.dwh_updated_tmsp AS dwh_updated_tmsp
, main.dwh_load_id AS dwh_load_id
, main.dwh_node_cd AS dwh_node_cd
 FROM CORE_DIM.T_DIM_SALES_VARIANT_1 main WHERE main.dwh_valid_fg;