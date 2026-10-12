CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_product_group_1 (
prod_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the group of marketable products or services.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
prod_grp_type_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the discriminator for product groups.'),
prod_grp_nr STRING(100) NOT NULL
OPTIONS(description='The number which identifies the group of products. (The number is unique among one type of product groups.)'),
prod_grp_name STRING(250) NOT NULL OPTIONS(description='The name of the product group.'),
prod_container_type_cd STRING(20)
OPTIONS(description='The code identifying the subtype discriminator for item_1 containers.'),
prod_container_class_cd STRING(20)
OPTIONS(description='The code distinguishing between module containers and surface containers.'),
prod_container_assort_area_cd STRING(20)
OPTIONS(description='The code identifying the assortment area, by which product containers can be classified.'),
prod_container_size_cd STRING(20)
OPTIONS(description='The code identifying the size class for module containers. (small / medium / large)'),
country_org_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for the country_1 organization which uses this product container.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (prod_grp_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A group of marketable products or services which has been formed for a specific purpose. (Note that a group of products is not a product!)');