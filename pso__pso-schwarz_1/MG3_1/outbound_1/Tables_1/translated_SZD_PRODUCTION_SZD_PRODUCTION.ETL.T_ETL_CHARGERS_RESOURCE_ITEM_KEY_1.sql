CREATE OR REPLACE TABLE szd_production_etl.t_etl_chargers_resource_item_key_1 (
resource_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the resource item.'),
resource_item_key_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the resource item.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
resource_item_nat_key_nr STRING(250) NOT NULL
OPTIONS(description='The natural key which identifies the resource item.In case the natural key consist of several columns, all components get concatenated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (resource_item_key_type_cd, dwh_valid_from_tmsp, resource_item_nat_key_nr) NOT ENFORCED
);