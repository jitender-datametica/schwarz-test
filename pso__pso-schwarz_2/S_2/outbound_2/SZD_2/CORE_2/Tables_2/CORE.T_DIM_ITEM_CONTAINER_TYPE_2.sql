CREATE TABLE IF NOT EXISTS szd_core.t_dim_item_container_type_2 (
item_container_type_cd STRING(250) NOT NULL
OPTIONS(description='The code of a container which can be foreign or own container'),
item_container_type_descr STRING(250) NOT NULL
OPTIONS(description='The description of a container which can be foreign or own container'),
item_container_type_descr_de STRING(250) NOT NULL
OPTIONS(description='The description of a container which can be foreign or own container in German'),
item_container_type_descr_en STRING(250) NOT NULL
OPTIONS(description='The description of a container which can be foreign or own container in English'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (item_container_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the item_2 container types of deposits e.g. own brand_2 ord foreign brand_2');