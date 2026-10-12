create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_SALES_VARIANT_2(
	SALES_VARIANT_SID COMMENT 'The unique identifier (surrogate key) for an sales_2 variant of a product.',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SALES_VARIANT_NR COMMENT 'The number by which the sales_2 variant is known to business.',
	GTIN COMMENT 'The Global Trade Item_2 Number (GTIN) that identifies this item_2 variant.',
	SALES_VARIANT_NAME COMMENT 'The name of the product variant.',
	PROD_VARIANT_STATUS_CD COMMENT 'A code that defines the lifecycle status_2 of the sales_2 variant,',
	PROD_VARIANT_STATUS_DESCR COMMENT 'A textual description for the status_2 code of a product variant in group language, i.e. in German.',
	SALES_VARIANT_TYPE_CD COMMENT 'The code identifying the subtype discriminator for sales_2 variants.',
	SALES_VARIANT_TYPE_DESCR COMMENT 'A textual description for the subtype discriminator for sales_2 variants. (Description in group language, i.e. in German)',
	WEIGHT_BASED_FG COMMENT 'An indicator showing, if the product variant is sold by weight instead of count.',
	SALES_VARIANT_CONTENT_MEAS COMMENT 'The content or size of the sales_2 variant. E.g. 750ml. In case the sales_2 variant consists of several units (e.g. 6 bottles with 1 liter each), this is the total content (i.e. 6 liters in this example). For weight-based products, this attribute is empty.',
	UNIT_CNT COMMENT 'In case the sales_2 variant consists of several units, this is the number of units, which are contained in the sales_2 variant. E.g. for a pack of 6 bottles this is 6. For weight-based products, this attribute is empty.',
	UNIT_CONTENT_MEAS COMMENT 'In case the sales_2 variant consists of several units, this is the content or size of a single unit. E.g. for a pack of 6 bottles of 1 liter each, this is 1 liter. For weight-based products, this attribute is empty.',
	CONTENT_UOM_CD COMMENT 'The code identifying the unit_2 of measure, such as kg, meter or pieces.',
	NON_FOOD_VARIANT_TYPE_CD COMMENT 'The code identifying the subtype discriminator for non food variants.',
	NON_FOOD_VARIANT_TYPE_DESCR COMMENT 'A textual description for the subtype discriminator for non food variants. (Description in group language, i.e. in German)',
	SIZE_NAME COMMENT 'The name for the size of the sales_2 variant. E.g. small / medium / large.',
	STYLE_NAME COMMENT 'The name for the style of the sales_2 variant, e.g. the color.',
	KIND_NAME COMMENT 'The name of the local variation of the product, e.g. for the kind of plug (European vs. UK vs. US style of plugs) or of the kind of fruits or vegetables.',
	FRUITS_AND_VEGETABLES_CLASS_CD COMMENT 'The code identifying the(quality) class for fruits and vegetables.',
	FRUITS_AND_VEGETABLES_CLASS_DESCR COMMENT 'A textual description for the (quality) class for fruits and vegetables. (Description in group language, i.e. in German)',
	MIN_CALIBER_MEAS COMMENT 'The minimum size (in the indicated unit_2 of measure) for this caliber.',
	MAX_CALIBER_MEAS COMMENT 'The maximum size (in the indicated unit_2 of measure) for this caliber.',
	CALIBER_UOM_CD COMMENT 'The code identifying the unit_2 of measure for the caliber.',
	COUNTRY_OF_ORIGIN_CD COMMENT 'The code identifying the country_2 of origin of the sales_2 variant, according to ISO 3166.',
	COUNTRY_OF_ORIGIN_NAME COMMENT 'The name of the country_2 of origin of this sales_2 variant.',
	PROD_SID COMMENT 'The unique identifier (surrogate key) for the product, which is the base for this sales_2 variant.',
	PROD_NR COMMENT 'The number which (globally) identifies the product which is the base for this sales_2 variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re_2-used later on.)',
	PROD_NAME COMMENT 'The name of the global product, which is the base for this sales_2 variant.',
	ITEM_FAM_SID COMMENT 'The unique identifier (surrogate key) for the related item_2 family, which contains this sales_2 variant.',
	ITEM_FAM_NR COMMENT 'The number by which the related item_2 family is known to business.',
	ITEM_FAM_NAME COMMENT 'The name of the item_2 related family in group language, i.e. in German.',
	SUB_ITEM_GRP_SID COMMENT 'The unique identifier (surrogate key) for the sub item_2 group, which contains this sales_2 variant.',
	SUB_ITEM_GRP_NR COMMENT 'The number by which the related sub item_2 group is known to business.',
	SUB_ITEM_GRP_NAME COMMENT 'The name of the related sub item_2 group in group language, i.e. in German.',
	INT_ITEM_GRP_SID COMMENT 'The unique identifier (surrogate key) for the international item_2 group, which contains this sales_2 variant.',
	INT_ITEM_GRP_NR COMMENT 'The number by which the related international item_2 group is known to business.',
	INT_ITEM_GRP_NAME COMMENT 'The name of the related international item_2 group in group language, i.e. in German.',
	PILLAR_SID COMMENT 'The unique identifier (surrogate key) for the pillar, which contains this sales_2 variant.',
	PILLAR_NR COMMENT 'The number by which the related pillar is known to business.',
	PILLAR_NAME COMMENT 'The name of the related pillar in group language, i.e. in German.',
	MAIN_PILLAR_SID COMMENT 'The unique identifier (surrogate key) for the top pillar, which contains this sales_2 variant.',
	MAIN_PILLAR_NR COMMENT 'The number by which the related top pillar is known to business.',
	MAIN_PILLAR_NAME COMMENT 'The name of the related top pillar in group language, i.e. in German.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) as SELECT
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
 FROM CORE_DIM.T_DIM_SALES_VARIANT_2 main WHERE main.dwh_valid_fg;