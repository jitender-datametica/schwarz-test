create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_LOCAL_LOGISTIC_VARIANT_1(
	LOGISTIC_VARIANT_SID COMMENT 'The unique identifier (surrogate key) for a logistic variant of a product.',
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the country_1 organization.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	LOCAL_LOGISTIC_VARIANT_NR COMMENT 'The number which identifies this logistic variant within the given market / internal organization.',
	LOCAL_LOGISTIC_VARIANT_NAME COMMENT 'The name of the logistic variant for the given market / internal organization.',
	PROD_VARIANT_STATUS_CD COMMENT 'A code that defines the lifecycle status_1 of the logistic variant,',
	PROD_VARIANT_STATUS_DESCR COMMENT 'A textual description for the status_1 code of a product variant in group language, i.e. in German.',
	PROD_SID COMMENT 'The unique identifier (surrogate key) for the product, which is the base for this logistic variant.',
	PROD_NR COMMENT 'The number which (globally) identifies the product which is the base for this logistic variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re_1-used later on.)',
	PROD_NAME COMMENT 'The name of the global product, which is the base for this logistic variant.',
	ITEM_FAM_SID COMMENT 'The unique identifier (surrogate key) for the item_1 family, which contains this logistic variant.',
	ITEM_FAM_NR COMMENT 'The number by which the related item_1 family is known to business.',
	ITEM_FAM_NAME COMMENT 'The name of the related item_1 family in group language, i.e. in German.',
	SUB_ITEM_GRP_SID COMMENT 'The unique identifier (surrogate key) for the sub item_1 group, which contains this logistic variant.',
	SUB_ITEM_GRP_NR COMMENT 'The number by which the related sub item_1 group is known to business.',
	SUB_ITEM_GRP_NAME COMMENT 'The name of the related sub item_1 group in group language, i.e. in German.',
	INT_ITEM_GRP_SID COMMENT 'The unique identifier (surrogate key) for the international item_1 group, which contains this logistic variant.',
	INT_ITEM_GRP_NR COMMENT 'The number by which the related international item_1 group is known to business.',
	INT_ITEM_GRP_NAME COMMENT 'The name of the related international item_1 group in group language, i.e. in German.',
	PILLAR_SID COMMENT 'The unique identifier (surrogate key) for the pillar, which contains this logistic variant.',
	PILLAR_NR COMMENT 'The number by which the related pillar is known to business.',
	PILLAR_NAME COMMENT 'The name of the related pillar in group language, i.e. in German.',
	MAIN_PILLAR_SID COMMENT 'The unique identifier (surrogate key) for the main pillar, which contains this logistic variant.',
	MAIN_PILLAR_NR COMMENT 'The number by which the related main pillar is known to business.',
	MAIN_PILLAR_NAME COMMENT 'The name of the related main pillar in group language, i.e. in German.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) as SELECT
 main.logistic_variant_sid
,main.country_org_sid
,main.country_org_cd
,main.dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp
,main.dwh_valid_fg
,main.local_logistic_variant_nr
,main.local_logistic_variant_name
,main.prod_variant_status_cd
,main.prod_variant_status_descr
,main.prod_sid
,main.prod_nr
,main.prod_name
,main.item_fam_sid
,main.item_fam_nr
,main.item_fam_name
,main.sub_item_grp_sid
,main.sub_item_grp_nr
,main.sub_item_grp_name
,main.int_item_grp_sid
,main.int_item_grp_nr
,main.int_item_grp_name
,main.pillar_sid
,main.pillar_nr
,main.pillar_name
,main.main_pillar_sid
,main.main_pillar_nr
,main.main_pillar_name
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_DIM.T_DIM_LOCAL_LOGISTIC_VARIANT_1 AS main
 WHERE main.dwh_valid_fg;