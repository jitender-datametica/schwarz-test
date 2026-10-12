CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_SUB_ITEM_GROUP(
	sub_item_grp_sid COMMENT 'The unique identifier (surrogate key) for a sub item group',
	dwh_valid_from_tmsp COMMENT 'The point in time when this record became valid.',
	dwh_valid_to_tmsp COMMENT 'The point in time when this record was no longer valid.',
	dwh_valid_fg COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	sub_item_grp_nr COMMENT 'The number by which the sub item group is known to business.',
	sub_item_grp_name COMMENT 'The name of the sub item group in group language, i.e. in German.',
	sub_item_grp_name_de COMMENT 'The name of the sub item group in German.',
	sub_item_grp_name_en COMMENT 'The name of the sub item group in English,',
	food_fg COMMENT 'An indicator distinguishing food from non-food items.',
	prod_grp_status_cd COMMENT 'The code identifying the lifecycle status for product groups.',
	prod_grp_status_descr COMMENT 'A textual description for the lifecycle status for product groups. (Description in group language, i.e. in German)',
	int_item_grp_sid COMMENT 'The unique identifier (surrogate key) of the international item group to which this sub item group belongs.',
	int_item_grp_nr COMMENT 'The number by which the related international item group is known to business.',
	int_item_grp_name COMMENT 'The name of the related international item group in group language, i.e. in German.',
	dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.',
	dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.',
	dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='A sub item group rolls up several item family groups.'
 AS SELECT
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
 FROM CORE_DIM.T_DIM_SUB_ITEM_GROUP main 
 WHERE main.dwh_valid_fg;