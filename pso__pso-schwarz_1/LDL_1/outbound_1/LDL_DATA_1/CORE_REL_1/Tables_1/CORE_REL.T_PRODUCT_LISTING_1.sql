/* --------------------------------------------------------------------------------
   DDL for table: t_product_listing_1
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_product_listing_1 (
prod_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
list_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the listing type, e.g. regular assortment, seasonal products, promotional items, etc.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_org_sid, prod_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This entity tracks the listing type for a product in a given market / internal organization. The listing types distinguishes the regular assortment from seasonal products, promotional items, etc.');