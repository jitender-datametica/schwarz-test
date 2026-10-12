CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_shelflife_type (
shelflife_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the condition on which a minimum shelflife is defined.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
shelflife_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the condition on which a minimum shelflife is defined.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (shelflife_type_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the conditon on which a minimum shelflife is defined. E.g. a product may only be offered in a store, if its shelflife is longer than x days. Or it may only be delivered from the warehouse to the store, if its shelflife is longer than y days. ');