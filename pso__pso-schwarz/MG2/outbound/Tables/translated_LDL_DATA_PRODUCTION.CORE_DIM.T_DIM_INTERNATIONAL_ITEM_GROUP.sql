CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_international_item_group (
int_item_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier [surrogate key] for an international item group.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
int_item_grp_nr STRING(100)
OPTIONS(description='The number by which the international item group is known to business.'),
int_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the international item group in group language, i.e. in German.'),
int_item_grp_name_de STRING(100) OPTIONS(description='The name of the international item group in German.'),
int_item_grp_name_en STRING(100) OPTIONS(description='The name of the international item group in English.'),
prod_grp_status_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status for product groups.'),
prod_grp_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status for product groups. (Description in group language, i.e. in German)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_item_grp_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The international item group is the highest level of the item hierarchy. It groups sub item groups.');