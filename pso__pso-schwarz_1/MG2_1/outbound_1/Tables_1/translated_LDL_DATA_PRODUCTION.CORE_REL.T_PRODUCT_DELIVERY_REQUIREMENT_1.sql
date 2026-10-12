CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_product_delivery_requirement_1 (
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization which has defined these requirements.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
deliv_temp_meas NUMERIC(29,5) OPTIONS(description='The (recommended) delivery temperature for the product.'),
min_deliv_temp_meas NUMERIC(29,5) OPTIONS(description='The minimum delivery temperature for the product.'),
max_deliv_temp_meas NUMERIC(29,5) OPTIONS(description='The maximum delivery temperature for the product.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_1 of measure.'),
shelflife_check_on_receipt_fg BOOL
OPTIONS(description='An indicator showing, if the minimum shelflife for this product shall be checked upon receipt.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_org_sid, prod_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='A product may require special treatment when transported. E.g. it must be kept refrigerated.');