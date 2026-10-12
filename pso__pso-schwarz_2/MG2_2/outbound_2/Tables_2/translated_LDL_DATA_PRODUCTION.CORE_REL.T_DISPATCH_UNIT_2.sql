CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_dispatch_unit_2 (
dispatch_unit_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the unit_2 of measure by which products get ordered, e.g. by pallet, by layer on a pallet, etc.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
dispatch_unit_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the unit_2 of measure by which products get ordered, e.g. by pallet, by layer on a pallet, etc.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (dispatch_unit_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='The dispatch unit_2 defines the unit_2 of measure by which products get ordered, e.g. by pallet, by layer on a pallet, etc.');