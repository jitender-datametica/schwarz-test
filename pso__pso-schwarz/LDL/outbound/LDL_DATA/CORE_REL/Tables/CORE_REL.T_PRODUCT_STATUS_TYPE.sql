/* --------------------------------------------------------------------------------
   DDL for table: t_product_status_type
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_product_status_type (
prod_status_categ_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of status lifecycle for products.'),
prod_status_type_cd STRING(20) NOT NULL OPTIONS(description='The code for the lifecycle status for products.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
prod_status_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status for products.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (prod_status_type_cd, lang_cd, prod_status_categ_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the lifecycle status for products. There may be more than one lifecycle for a given product, e.g. the buying status and the workflow status for non-food items or the status in the retail system. The lifecycle is identified by the status category code. For a given status category, a product has one status code.');