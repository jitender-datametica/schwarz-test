CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_dim_sub_item_group_1 (sub_item_grp_sid
OPTIONS(description='The unique identifier (surrogate key) for a sub item_1 group'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
sub_item_grp_nr OPTIONS(description='The number by which the sub item_1 group is known to business.'), sub_item_grp_name
OPTIONS(description='The name of the sub item_1 group in group language, i.e. in German.'), sub_item_grp_name_de
OPTIONS(description='The name of the sub item_1 group in German.'), sub_item_grp_name_en
OPTIONS(description='The name of the sub item_1 group in English,'), food_fg
OPTIONS(description='An indicator distinguishing food from non-food items.'), prod_grp_status_cd
OPTIONS(description='The code identifying the lifecycle status_1 for product groups.'), prod_grp_status_descr
OPTIONS(description='A textual description for the lifecycle status_1 for product groups. (Description in group language, i.e. in German)'),
int_item_grp_sid
OPTIONS(description='The unique identifier (surrogate key) of the international item_1 group to which this sub item_1 group belongs.'),
int_item_grp_nr OPTIONS(description='The number by which the related international item_1 group is known to business.'),
int_item_grp_name
OPTIONS(description='The name of the related international item_1 group in group language, i.e. in German.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `A SUB ITEM_1 GROUP ROLLS UP SEVERAL ITEM_1 FAMILY GROUPS.`) AS SELECT sub_item_grp_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 sub_item_grp_nr,
 sub_item_grp_name,
 sub_item_grp_name_de,
 sub_item_grp_name_en,
 food_fg,
 prod_grp_status_cd,
 prod_grp_status_descr,
 int_item_grp_sid,
 int_item_grp_nr,
 int_item_grp_name,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_sub_item_group_1 AS main
WHERE dwh_valid_fg;