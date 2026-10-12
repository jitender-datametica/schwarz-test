/* --------------------------------------------------------------------------------
   DDL for table: t_local_product_variant
   generated from Powerdesigner on Montag, 20. November 2023 12:40:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_local_product_variant (
prod_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a variant of a product.'),
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
local_prod_variant_nr STRING(100)
OPTIONS(description='The number which identifies the product variant within the given market / internal organization.'),
local_prod_variant_name STRING(500)
OPTIONS(description='The name of the product variant for the given market / internal organization.'),
prod_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the product which is the base for this variant.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_org_sid, prod_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A product variant may be sold under different names or is identified by different numbers, depending on the market or organization. This entity tracks the local properties of a product variant.');