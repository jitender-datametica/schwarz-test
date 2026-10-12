CREATE OR REPLACE TABLE ldl_data_production_etl.t_precore_price_group_to_internal_organization (
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization to which the price group applies'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
price_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the price level of a product.'),
price_grp_prio INTEGER
OPTIONS(description='In case several prices are defined for one product, the price originating from the price group is used, which has the highest priority for the given store or warehouse.'),
datefrom DATETIME NOT NULL,
dateto DATETIME,
open_dt DATE OPTIONS(description='The date when this real estate object was opened.'),
close_dt DATE OPTIONS(description='The date when this real estate object was closed.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_org_sid, price_grp_sid, datefrom) NOT ENFORCED
)
OPTIONS(description='Prices in stores and warehouses (delivery companies) are defined based on price groups. This entity relates an internal organization to all applicable price groups. The priority defines which price group is used, in case several prices are defined for one product.');