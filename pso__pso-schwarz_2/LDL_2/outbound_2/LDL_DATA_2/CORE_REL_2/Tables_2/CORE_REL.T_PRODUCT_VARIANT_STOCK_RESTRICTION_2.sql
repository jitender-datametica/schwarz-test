/* --------------------------------------------------------------------------------
   DDL for table: t_product_variant_stock_restriction_2
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_product_variant_stock_restriction_2 (
prod_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a variant of a product, for which the restriction applies.'),
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization which defines the restriction.'),
stock_restriction_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the the kind of restriction regarding the stock which has to be kept for a product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
stock_qty BIGNUMERIC(38,5) NOT NULL OPTIONS(description='The stock quantity which is desribed by the restriction.'),
logistic_uom_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the logistic unit_2 of measure. (e.g. palettes, boxes, pieces or layers on a palette)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (stock_restriction_type_cd, int_org_sid, prod_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Some product need to be available in certain quantities, e.g. there is a mininum or a maximum stock quantity.');