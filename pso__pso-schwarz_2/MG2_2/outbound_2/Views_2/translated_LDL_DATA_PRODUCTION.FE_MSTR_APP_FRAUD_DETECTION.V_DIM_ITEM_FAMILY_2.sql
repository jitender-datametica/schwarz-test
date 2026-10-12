CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_dim_item_family_2 (item_fam_sid
OPTIONS(description='The unique identifier (surrogate key) for the item_2 family.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
item_fam_nr OPTIONS(description='The number by which the item_2 family is known to business.'), item_fam_name
OPTIONS(description='The name of the item_2 family in group language, i.e. in German.'), item_fam_name_de
OPTIONS(description='The name of the item_2 family in German.'), item_fam_name_en
OPTIONS(description='The name of the item_2 family in English.'), prod_grp_status_cd
OPTIONS(description='The code identifying the lifecycle status_2 for product groups.'), prod_grp_status_descr
OPTIONS(description='A textual description for the lifecycle status_2 for product groups. (Description in group language, i.e. in German)'),
sub_item_grp_sid
OPTIONS(description='The unique identifier (surrogate key) for a sub item_2 group to which this item_2 family group belongs.'),
sub_item_grp_nr OPTIONS(description='The number by which the related sub item_2 group is known to business.'),
sub_item_grp_name OPTIONS(description='The name of the related sub item_2 group in group language, i.e. in German.'),
food_fg OPTIONS(description='An indicator distinguishing food from non-food items.'), int_item_grp_sid
OPTIONS(description='The unique identifier (surrogate key) of the international item_2 group, to which this item_2 family belongs.'),
int_item_grp_nr OPTIONS(description='The number by which the related international item_2 group is known to business.'),
int_item_grp_name
OPTIONS(description='The name of the related international item_2 group in group language, i.e. in German.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THE ITEM_2 FAMILY IS THE LOWEST GROUPING LEVEL FOR ITEMS. `) AS SELECT item_fam_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 item_fam_nr,
 item_fam_name,
 item_fam_name_de,
 item_fam_name_en,
 prod_grp_status_cd,
 prod_grp_status_descr,
 sub_item_grp_sid,
 sub_item_grp_nr,
 sub_item_grp_name,
 food_fg,
 int_item_grp_sid,
 int_item_grp_nr,
 int_item_grp_name,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_item_family_2 AS main
WHERE dwh_valid_fg;