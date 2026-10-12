CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_product_container_class_1 (
prod_container_class_cd STRING(20) NOT NULL
OPTIONS(description='The code distinguishing between module containers, area containers and technical containers.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
prod_container_class_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the product container class.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (prod_container_class_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity distinguishes between module containers, area containers and technical containers. A module container contains a set of related products. If a module container is assigned to a store, the store offers all these products. An area container is of a specific size (small / medium / large / etc.). Area containers are cumulative. I.e. a product is assigned to only one container. Depending on the sales_1 area allocated in the store, all containers up to the chosen size get allocated to the store So if a store has a sales_1 area of size Large for a specific category, it gets the containers for Small, Medium and Large assigned. Technical containers serve for test_1 purposes or as temporary containers, e.g. in case of retro-fitting of a store.');