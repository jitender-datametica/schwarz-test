CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_inventory_reason (
inv_reason_id INTEGER NOT NULL OPTIONS(description='The identifier for the reason why an inventory was initiated.'),
inv_reason_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the reason why an inventory was initiated. (Description in group language, i.e. in German)'),
inv_reason_descr_de STRING(250)
OPTIONS(description='A textual description for the reason why an inventory was initiated. (Description in German)'),
inv_reason_descr_en STRING(250)
OPTIONS(description='A textual description for the reason why an inventory was initiated. (Description in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (inv_reason_id) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the reason why an inventory was initiated. (The inventory reason only applies to partial inventories.)');