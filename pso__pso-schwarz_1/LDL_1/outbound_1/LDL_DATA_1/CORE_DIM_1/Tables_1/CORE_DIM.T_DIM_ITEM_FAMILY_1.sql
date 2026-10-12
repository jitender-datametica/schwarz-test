/* --------------------------------------------------------------------------------
   DDL for table: t_dim_item_family_1
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_item_family_1 (
item_fam_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the item_1 family.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
item_fam_nr STRING(100) OPTIONS(description='The number by which the item_1 family is known to business.'),
item_fam_name STRING(100) NOT NULL OPTIONS(description='The name of the item_1 family in group language, i.e. in German.'),
item_fam_name_de STRING(100) OPTIONS(description='The name of the item_1 family in German.'),
item_fam_name_en STRING(100) OPTIONS(description='The name of the item_1 family in English.'),
prod_grp_status_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status_1 for product groups.'),
prod_grp_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status_1 for product groups. (Description in group language, i.e. in German)'),
sub_item_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sub item_1 group to which this item_1 family group belongs.'),
sub_item_grp_nr STRING(100) OPTIONS(description='The number by which the related sub item_1 group is known to business.'),
sub_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the related sub item_1 group in group language, i.e. in German.'),
food_fg BOOL NOT NULL OPTIONS(description='An indicator distinguishing food from non-food items.'),
int_item_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the international item_1 group, to which this item_1 family belongs.'),
int_item_grp_nr STRING(100)
OPTIONS(description='The number by which the related international item_1 group is known to business.'),
int_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the related international item_1 group in group language, i.e. in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (item_fam_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='The item_1 family is the lowest grouping level for items. ');