CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_ITEM_FAMILY_2(
	item_fam_sid COMMENT 'The unique identifier (surrogate key) for the item_2 family.',
	dwh_valid_from_tmsp COMMENT 'The point in time when this record became valid.',
	dwh_valid_to_tmsp COMMENT 'The point in time when this record was no longer valid.',
	dwh_valid_fg COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	item_fam_nr COMMENT 'The number by which the item_2 family is known to business.',
	item_fam_name COMMENT 'The name of the item_2 family in group language, i.e. in German.',
	item_fam_name_de COMMENT 'The name of the item_2 family in German.',
	item_fam_name_en COMMENT 'The name of the item_2 family in English.',
	prod_grp_status_cd COMMENT 'The code identifying the lifecycle status_2 for product groups.',
	prod_grp_status_descr COMMENT 'A textual description for the lifecycle status_2 for product groups. (Description in group language, i.e. in German)',
	sub_item_grp_sid COMMENT 'The unique identifier (surrogate key) for a sub item_2 group to which this item_2 family group belongs.',
	sub_item_grp_nr COMMENT 'The number by which the related sub item_2 group is known to business.',
	sub_item_grp_name COMMENT 'The name of the related sub item_2 group in group language, i.e. in German.',
	food_fg COMMENT 'An indicator distinguishing food from non-food items.',
	int_item_grp_sid COMMENT 'The unique identifier (surrogate key) of the international item_2 group, to which this item_2 family belongs.',
	int_item_grp_nr COMMENT 'The number by which the related international item_2 group is known to business.',
	int_item_grp_name COMMENT 'The name of the related international item_2 group in group language, i.e. in German.',
	dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.',
	dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.',
	dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='The item_2 family is the lowest grouping level for items. '
 AS SELECT  
  main.item_fam_sid	AS item_fam_sid
, main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
, main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp	
, main.dwh_valid_fg	AS dwh_valid_fg
, main.item_fam_nr AS item_fam_nr
, main.item_fam_name AS item_fam_name	
, main.item_fam_name_de AS item_fam_name_de	
, main.item_fam_name_en AS item_fam_name_en	
, main.prod_grp_status_cd AS prod_grp_status_cd	
, main.prod_grp_status_descr AS prod_grp_status_descr	
, main.sub_item_grp_sid AS sub_item_grp_sid
, main.sub_item_grp_nr AS sub_item_grp_nr	
, main.sub_item_grp_name AS sub_item_grp_name	
, main.food_fg AS food_fg	
, main.int_item_grp_sid AS int_item_grp_sid	
, main.int_item_grp_nr AS int_item_grp_nr	
, main.int_item_grp_name AS int_item_grp_name		
, main.dwh_created_tmsp	AS dwh_created_tmsp
, main.dwh_updated_tmsp AS dwh_updated_tmsp	
, main.dwh_load_id AS dwh_load_id	
, main.dwh_node_cd AS dwh_node_cd	
 FROM CORE_DIM.T_DIM_ITEM_FAMILY_2 main 
 WHERE main.dwh_valid_fg;