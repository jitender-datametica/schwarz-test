CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_unit_of_measure (
uom_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the unit of measure.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
uom_name STRING(100) NOT NULL OPTIONS(description='The name for the unit of measure.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (uom_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='The unit in which a quantity is expressed. This includes mostly physical units, such as kilogram, meters or seconds, but also units such as slices or pieces.');