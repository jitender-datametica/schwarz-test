create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_SUB_ITEM_GROUP_2(
	SUB_ITEM_GRP_SID COMMENT 'The unique identifier (surrogate key) for a sub item_2 group',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SUB_ITEM_GRP_NR COMMENT 'The number by which the sub item_2 group is known to business.',
	SUB_ITEM_GRP_NAME COMMENT 'The name of the sub item_2 group in group language, i.e. in German.',
	SUB_ITEM_GRP_NAME_DE COMMENT 'The name of the sub item_2 group in German.',
	SUB_ITEM_GRP_NAME_EN COMMENT 'The name of the sub item_2 group in English,',
	FOOD_FG COMMENT 'An indicator distinguishing food from non-food items.',
	PROD_GRP_STATUS_CD COMMENT 'The code identifying the lifecycle status_2 for product groups.',
	PROD_GRP_STATUS_DESCR COMMENT 'A textual description for the lifecycle status_2 for product groups. (Description in group language, i.e. in German)',
	INT_ITEM_GRP_SID COMMENT 'The unique identifier (surrogate key) of the international item_2 group to which this sub item_2 group belongs.',
	INT_ITEM_GRP_NR COMMENT 'The number by which the related international item_2 group is known to business.',
	INT_ITEM_GRP_NAME COMMENT 'The name of the related international item_2 group in group language, i.e. in German.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='A sub item_2 group rolls up several item_2 family groups.'
 as SELECT
  main.sub_item_grp_sid AS sub_item_grp_sid
, main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
, main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
, main.dwh_valid_fg AS dwh_valid_fg
, main.sub_item_grp_nr AS sub_item_grp_nr
, main.sub_item_grp_name AS sub_item_grp_name
, main.sub_item_grp_name_de AS sub_item_grp_name_de
, main.sub_item_grp_name_en AS sub_item_grp_name_en
, main.food_fg AS food_fg
, main.prod_grp_status_cd AS prod_grp_status_cd
, main.prod_grp_status_descr AS prod_grp_status_descr
, main.int_item_grp_sid AS int_item_grp_sid
, main.int_item_grp_nr AS int_item_grp_nr
, main.int_item_grp_name AS int_item_grp_name
, main.dwh_created_tmsp AS dwh_created_tmsp
, main.dwh_updated_tmsp AS dwh_updated_tmsp
, main.dwh_load_id AS dwh_load_id
, main.dwh_node_cd AS dwh_node_cd
 FROM CORE_DIM.T_DIM_SUB_ITEM_GROUP_2 main 
 WHERE main.dwh_valid_fg;