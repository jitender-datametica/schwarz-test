CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_unit_of_measure_2 (
uom_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the unit_2 of measure, such as kg, meter or pieces.'),
uom_name STRING(100) NOT NULL OPTIONS(description='The name for the unit_2 of measure in group language, i.e. in German.'),
uom_name_de STRING(100) OPTIONS(description='The name for the unit_2 of measure in German.'),
uom_name_en STRING(100) OPTIONS(description='The name for the unit_2 of measure in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (uom_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines units of measure, such as kg, meter or pieces');