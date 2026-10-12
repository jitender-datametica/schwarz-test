CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_product_identification_1 (
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
int_org_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
prod_ident_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the type of number which identifies a product.'),
prod_ident_nr STRING(20) NOT NULL OPTIONS(description='The number which identifies the product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (prod_sid, int_org_sid, prod_ident_type_cd, prod_ident_nr, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This entity tracks additional numbers which are used to identify the product. The kind of number is defined by the Product Identification Type Code. A product may be identified by multiple numbers, even of the same type. E.g. due to internal restrictions, the retail system may create several numbers for the same product.');