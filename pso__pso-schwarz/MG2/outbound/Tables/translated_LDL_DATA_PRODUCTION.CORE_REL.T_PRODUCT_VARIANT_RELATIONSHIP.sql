CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_product_variant_relationship (
prod_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a variant of a product.'),
rel_prod_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related variant of a product.'),
prod_variant_rel_type_cd STRING(20) NOT NULL
OPTIONS(description='A code defining the way, how two product variants are related to each other.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
prod_variant_cnt INTEGER
OPTIONS(description='In case the relationship describes which sales variants are contained in a logistic variant, this is the number of contained sales variants.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (prod_variant_sid, rel_prod_variant_sid, prod_variant_rel_type_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Products may be related to each other. E.g. one product may be the successor of another product. The kind of relationship is defined by the relationship type code.');