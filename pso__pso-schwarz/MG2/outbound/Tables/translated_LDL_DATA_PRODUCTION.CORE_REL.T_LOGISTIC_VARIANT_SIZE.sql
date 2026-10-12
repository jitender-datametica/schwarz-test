CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_logistic_variant_size (
prod_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a logistic variant of a product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
length_meas NUMERIC(29,5)
OPTIONS(description='The length of the logistic variant, expressed in the indicated unit of measure.'),
width_meas NUMERIC(29,5)
OPTIONS(description='The width of the logistic variant, expressed in the indicated unit of measure.'),
height_meas NUMERIC(29,5)
OPTIONS(description='The height of the logistic variant, expressed in the indicated unit of measure.'),
size_uom_cd STRING(20) OPTIONS(description='The code identifying the unit of measure for the length, width and height.'),
net_weight_meas NUMERIC(29,5)
OPTIONS(description='The net weight (i.e. excluding packing material) of the logistic variant, expressed in the indicated unit of measure.'),
gross_weight_meas NUMERIC(29,5)
OPTIONS(description='The gross weight (i.e. including packing material) of the logistic variant, expressed in the indicated unit of measure.'),
weight_uom_cd STRING(20) OPTIONS(description='The code identifying the unit of measure.'),
units_per_pallet_cnt INTEGER
OPTIONS(description='The number of logistic variants which can be packed on a pallet. (The type of pallet is indicated by the Pallet Type Code.)'),
units_per_pallet_layer_cnt INTEGER
OPTIONS(description='The number of logistic variants which can be packed on one layer of a pallet. (The type of pallet is indicated by the Pallet Type Code.)'),
pallet_type_cd STRING(20)
OPTIONS(description='The code identifying the kind of pallet. (Euro-pallet vs. Duesseldorfer pallet)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (prod_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='This entity tracks the physical size and weight of a logistic variant.');