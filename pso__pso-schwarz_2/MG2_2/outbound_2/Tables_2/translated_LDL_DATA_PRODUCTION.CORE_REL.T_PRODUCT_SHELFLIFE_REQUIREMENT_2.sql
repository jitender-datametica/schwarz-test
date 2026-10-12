CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_product_shelflife_requirement_2 (
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization, for which the minimum shelflife is defined.'),
shelflife_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the condition on which a minimum shelflife is defined.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
shelflife_day_cnt INTEGER OPTIONS(description='The minimum shelflife of the product in days.'),
standard_shelflife_fg BOOL OPTIONS(description='An indicator showing, if this is the standard shelflife.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_org_sid, prod_sid, shelflife_type_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This entity tracks the minimum shelflife conditions for a product. E.g. a product may only be offered in a store, if its shelflife is longer than x days. Or it may only be delivered from the warehouse to the store, if its shelflife is longer than y days. The shilflife type defines the condition.');