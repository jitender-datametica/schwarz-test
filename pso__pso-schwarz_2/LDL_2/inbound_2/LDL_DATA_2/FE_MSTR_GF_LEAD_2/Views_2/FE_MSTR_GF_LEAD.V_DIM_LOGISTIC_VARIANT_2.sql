CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_LOGISTIC_VARIANT_2(
	LOGISTIC_VARIANT_SID COMMENT 'The unique identifier (surrogate key) for a logistic variant of a product.',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	LOGISTIC_VARIANT_NR COMMENT 'The number by which the logistic variant is known to business.',
	LOGISTIC_VARIANT_NAME COMMENT 'The name of the logistic variant.',
	LOGISTIC_VARIANT_TYPE_CD COMMENT 'The code identifying the subtype discriminator for logistic variants.',
	LOGISTIC_VARIANT_TYPE_DESCR COMMENT 'A textual description for the subtype discriminator for logistic variants. (Description in group language, i.e. in German)',
	PROD_VARIANT_STATUS_CD COMMENT 'A code that defines the lifecycle status_2 of the logistic variant,',
	PROD_VARIANT_STATUS_DESCR COMMENT 'A textual description for the status_2 code of a product variant in group language, i.e. in German.',
	CASE_SIZE_CNT COMMENT 'The number of individual items that are contained in the logistic variant. (Note that the individual item_2 represents the smallest sellable unit. E.g. if a packed try of meat contains two slices, the entire tray is considered one sellable unit.)',
	WEIGHT_BASED_FG COMMENT 'An indicator showing, if the product variant is delivered by weight instead of count.',
	LENGTH_MEAS COMMENT 'The length of the logistic variant, expressed in the indicated unit_2 of measure.',
	WIDTH_MEAS COMMENT 'The width of the logistic variant, expressed in the indicated unit_2 of measure.',
	HEIGHT_MEAS COMMENT 'The height of the logistic variant, expressed in the indicated unit_2 of measure.',
	SIZE_UOM_CD COMMENT 'The code identifying the unit_2 of measure for the length, width and height.',
	NET_WEIGHT_MEAS COMMENT 'The net weight (i.e. excluding packing material) of the logistic variant, expressed in the indicated unit_2 of measure.',
	GROSS_WEIGHT_MEAS COMMENT 'The gross weight (i.e. including packing material) of the logistic variant, expressed in the indicated unit_2 of measure.',
	WEIGHT_UOM_CD COMMENT 'The code identifying the unit_2 of measure.',
	UNITS_PER_PALLET_CNT COMMENT 'The number of logistic variants which can be packed on a pallet. (The type of pallet is indicated by the Pallet Type Code.)',
	UNITS_PER_PALLET_LAYER_CNT COMMENT 'The number of logistic variants which can be packed on one layer of a pallet. (The type of pallet is indicated by the Pallet Type Code.)',
	PALLET_TYPE_CD COMMENT 'The code identifying the kind of pallet. (Euro-pallet vs. Duesseldorfer pallet)',
	PALLET_TYPE_DESCR COMMENT 'A textual description for the kind of pallet. (Description in group language, i.e. in German)',
	PROD_SID COMMENT 'The unique identifier (surrogate key) for the product, which is the base for this logistic variant.',
	PROD_NR COMMENT 'The number which (globally) identifies the product which is the base for this logistic variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re_2-used later on.)',
	PROD_NAME COMMENT 'The name of the global product, which is the base for this logistic variant.',
	ITEM_FAM_SID COMMENT 'The unique identifier (surrogate key) for the item_2 family, which contains this logistic variant.',
	ITEM_FAM_NR COMMENT 'The number by which the related item_2 family is known to business.',
	ITEM_FAM_NAME COMMENT 'The name of the related item_2 family in group language, i.e. in German.',
	SUB_ITEM_GRP_SID COMMENT 'The unique identifier (surrogate key) for the sub item_2 group, which contains this logistic variant.',
	SUB_ITEM_GRP_NR COMMENT 'The number by which the related sub item_2 group is known to business.',
	SUB_ITEM_GRP_NAME COMMENT 'The name of the related sub item_2 group in group language, i.e. in German.',
	INT_ITEM_GRP_SID COMMENT 'The unique identifier (surrogate key) for the international item_2 group, which contains this logistic variant.',
	INT_ITEM_GRP_NR COMMENT 'The number by which the related international item_2 group is known to business.',
	INT_ITEM_GRP_NAME COMMENT 'The name of the related international item_2 group in group language, i.e. in German.',
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
) AS SELECT
 main.logistic_variant_sid
,main.dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp
,main.dwh_valid_fg
,main.logistic_variant_nr
,main.logistic_variant_name
,main.logistic_variant_type_cd
,main.logistic_variant_type_descr
,main.prod_variant_status_cd
,main.prod_variant_status_descr
,main.case_size_cnt
,main.weight_based_fg
,main.length_meas
,main.width_meas
,main.height_meas
,main.size_uom_cd
,main.net_weight_meas
,main.gross_weight_meas
,main.weight_uom_cd
,main.units_per_pallet_cnt
,main.units_per_pallet_layer_cnt
,main.pallet_type_cd
,main.pallet_type_descr
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
FROM CORE_DIM.T_DIM_LOGISTIC_VARIANT_2 AS main
 WHERE main.dwh_valid_fg;