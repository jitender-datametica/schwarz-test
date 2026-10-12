CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_product_group_hierarchy_1 (
prod_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the group of marketable products or services.'),
prod_grp_hierarchy_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of hierarchy_1 for product groups.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
parent_prod_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the group of marketable products or services, which is one level up in the hierarchy_1 defined by the hierarchy_1 type code.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (prod_grp_hierarchy_type_cd, prod_grp_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This entity tracks the hierarchy_1 of product groups. It relates a group of products to its parent group one level up in the hierarchy. This entity can store multiple hierarchies. The kind of hierarchy_1 is identified by the hierarchy_1 type code.');