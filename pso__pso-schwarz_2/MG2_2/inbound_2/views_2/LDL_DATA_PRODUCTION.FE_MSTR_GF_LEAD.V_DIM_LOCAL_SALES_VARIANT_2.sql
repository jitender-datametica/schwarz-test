create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_LOCAL_SALES_VARIANT_2(
	SALES_VARIANT_SID COMMENT 'The unique identifier (surrogate key) for the sales_2 variant of a product.',
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the country_2 organization.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	LOCAL_SALES_VARIANT_NR COMMENT 'The number which identifies the product variant within the given market / internal organization.',
	LOCAL_SALES_VARIANT_NAME COMMENT 'The name of the product variant for the given market / internal organization.',
	PROD_VARIANT_STATUS_CD COMMENT 'A code that defines the lifecycle status_2 of a product variant, i.e. of a sales_2 variant or a logistc variant.',
	PROD_VARIANT_STATUS_DESCR COMMENT 'A textual description for the status_2 code of a product variant in group language, i.e. in German.',
	PROD_SID COMMENT 'The unique identifier (surrogate key) for the product.',
	PROD_NR COMMENT 'The number which (globally) identifies the product which is the base for this sales_2 variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re_2-used later on.)',
	PROD_NAME COMMENT 'The name of the global product, which is the base for this sales_2 variant.',
	ITEM_FAM_SID COMMENT 'The unique identifier (surrogate key) for the related item_2 family.',
	ITEM_FAM_NR COMMENT 'The number by which the related item_2 family is known to business.',
	ITEM_FAM_NAME COMMENT 'The name of the related item_2 family in group language, i.e. in German.',
	SUB_ITEM_GRP_SID COMMENT 'The unique identifier (surrogate key) for the related sub item_2 group',
	SUB_ITEM_GRP_NR COMMENT 'The number by which the sub item_2 group is known to business.',
	SUB_ITEM_GRP_NAME COMMENT 'The name of the related sub item_2 group in group language, i.e. in German.',
	INT_ITEM_GRP_SID COMMENT 'The unique identifier [surrogate key] for the related international item_2 group.',
	INT_ITEM_GRP_NR COMMENT 'The number by which the related international item_2 group is known to business.',
	INT_ITEM_GRP_NAME COMMENT 'The name of the related international item_2 group in group language, i.e. in German.',
	PILLAR_SID COMMENT 'The unique identifier (surrogate key) for the related pillar.',
	PILLAR_NR COMMENT 'The number by which the related pillar is known to business.',
	PILLAR_NAME COMMENT 'The name of the related pillar in group language, i.e. in German.',
	MAIN_PILLAR_SID COMMENT 'The unique identifier (surrogate key) for the related top pillar.',
	MAIN_PILLAR_NR COMMENT 'The number by which the related top pillar is known to business.',
	MAIN_PILLAR_NAME COMMENT 'The name of the related top pillar in group language, i.e. in German.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) as SELECT
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
 FROM CORE_DIM.T_DIM_LOCAL_SALES_VARIANT_2 main 
 WHERE main.dwh_valid_fg;