CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_DIM_LOCAL_SALES_VARIANT(
	sales_variant_sid COMMENT 'The unique identifier (surrogate key) for the sales variant of a product.',
	country_org_sid COMMENT 'The unique identifier (surrogate key) for the country organization.',
	country_org_cd COMMENT 'The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)',
	dwh_valid_from_tmsp COMMENT 'The point in time when this record became valid.',
	dwh_valid_to_tmsp COMMENT 'The point in time when this record was no longer valid.',
	dwh_valid_fg COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	local_sales_variant_nr COMMENT 'The number which identifies the product variant within the given market / internal organization.',
	local_sales_variant_name COMMENT 'The name of the product variant for the given market / internal organization.',
	prod_variant_status_cd COMMENT 'A code that defines the lifecycle status of a product variant, i.e. of a sales variant or a logistc variant.',
	prod_variant_status_descr COMMENT 'A textual description for the status code of a product variant in group language, i.e. in German.',
	prod_sid COMMENT 'The unique identifier (surrogate key) for the product.',
	prod_nr COMMENT 'The number which (globally) identifies the product which is the base for this sales variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re-used later on.)',
	prod_name COMMENT 'The name of the global product, which is the base for this sales variant.',
	item_fam_sid COMMENT 'The unique identifier (surrogate key) for the related item family.',
	item_fam_nr COMMENT 'The number by which the related item family is known to business.',
	item_fam_name COMMENT 'The name of the related item family in group language, i.e. in German.',
	sub_item_grp_sid COMMENT 'The unique identifier (surrogate key) for the related sub item group',
	sub_item_grp_nr COMMENT 'The number by which the sub item group is known to business.',
	sub_item_grp_name COMMENT 'The name of the related sub item group in group language, i.e. in German.',
	int_item_grp_sid COMMENT 'The unique identifier [surrogate key] for the related international item group.',
	int_item_grp_nr COMMENT 'The number by which the related international item group is known to business.',
	int_item_grp_name COMMENT 'The name of the related international item group in group language, i.e. in German.',
	pillar_sid COMMENT 'The unique identifier (surrogate key) for the related pillar.',
	pillar_nr COMMENT 'The number by which the related pillar is known to business.',
	pillar_name COMMENT 'The name of the related pillar in group language, i.e. in German.',
	main_pillar_sid COMMENT 'The unique identifier (surrogate key) for the related top pillar.',
	main_pillar_nr COMMENT 'The number by which the related top pillar is known to business.',
	main_pillar_name COMMENT 'The name of the related top pillar in group language, i.e. in German.',
	dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.',
	dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.',
	dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) AS SELECT
main.sales_variant_sid AS sales_variant_sid
, main.country_org_sid AS country_org_sid
, main.country_org_cd AS country_org_cd
, main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
, main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
, main.dwh_valid_fg AS dwh_valid_fg
, main.local_sales_variant_nr AS local_sales_variant_nr
, main.local_sales_variant_name AS local_sales_variant_name
, main.prod_variant_status_cd AS prod_variant_status_cd
, main.prod_variant_status_descr AS prod_variant_status_descr
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
, main.main_pillar_sid AS main_pllar_sid
, main.main_pillar_nr AS main_pllar_nr
, main.main_pillar_name AS main_pllar_name
, main.dwh_created_tmsp AS dwh_created_tmsp
, main.dwh_updated_tmsp AS dwh_updated_tmsp
, main.dwh_load_id AS dwh_load_id
, main.dwh_node_cd AS dwh_node_cd
 FROM CORE_DIM.T_DIM_LOCAL_SALES_VARIANT main 
 WHERE main.dwh_valid_fg;