CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_price_group_to_internal_organization (
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization to which the price group applies'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
price_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the price level of a product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
price_grp_prio INTEGER
OPTIONS(description='In case several prices are defined for one product, the price originating from the price group is used, which has the highest priority for the given store or warehouse.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_org_sid, price_grp_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Prices in stores and warehouses (delivery companies) are defined based on price groups. This entity relates an internal organization to all applicable price groups. The priority defines which price group is used, in case several prices are defined for one product.');