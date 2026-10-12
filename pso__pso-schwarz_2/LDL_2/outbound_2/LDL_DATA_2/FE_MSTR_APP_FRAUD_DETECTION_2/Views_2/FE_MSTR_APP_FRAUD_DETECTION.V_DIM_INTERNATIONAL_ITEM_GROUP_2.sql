CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_international_item_group_2 (int_item_grp_sid
OPTIONS(description='The unique identifier [surrogate key] for an international item_2 group.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
int_item_grp_nr OPTIONS(description='The number by which the international item_2 group is known to business.'),
int_item_grp_name OPTIONS(description='The name of the international item_2 group in group language, i.e. in German.'),
int_item_grp_name_de OPTIONS(description='The name of the international item_2 group in German.'), int_item_grp_name_en
OPTIONS(description='The name of the international item_2 group in English.'), prod_grp_status_cd
OPTIONS(description='The code identifying the lifecycle status_2 for product groups.'), prod_grp_status_descr
OPTIONS(description='A textual description for the lifecycle status_2 for product groups. (Description in group language, i.e. in German)'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THE INTERNATIONAL ITEM_2 GROUP IS THE HIGHEST LEVEL OF THE ITEM_2 HIERARCHY. IT GROUPS SUB ITEM_2 GROUPS.`)
AS SELECT *
FROM ldl_data_core_dim.t_dim_international_item_group_2 AS MAIN
WHERE dwh_valid_fg;