CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_pallet_type_1 (
pallet_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of pallet. (Euro-pallet vs. Duesseldorfer pallet)'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
pallet_type_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the kind of pallet.'),
pallet_space_factor NUMERIC(29,5)
OPTIONS(description='The ratio of the floor space consumed by this palett type compared with the floor space of a Euro palett. E.g. 0,5 für a Duesseldorfer palett.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (pallet_type_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the various types of pallets, E.g. Euro-pallets and Duesseldorfer pallets.');