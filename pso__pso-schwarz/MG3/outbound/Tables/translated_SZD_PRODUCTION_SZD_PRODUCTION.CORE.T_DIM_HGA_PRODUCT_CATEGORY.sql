CREATE OR REPLACE TABLE szd_production_core.t_dim_hga_product_category (
hga_product_cat_id INTEGER NOT NULL OPTIONS(description='The code for a hot beverage product'),
hga_product_cat_name STRING(100) NOT NULL OPTIONS(description='The default textual name for hot beverage products'),
hga_product_cat_name_de STRING(100) NOT NULL
OPTIONS(description='The textual name for hot beverage products in German.'),
hga_product_cat_name_en STRING(100) NOT NULL
OPTIONS(description='The textual name for hot beverage products in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (hga_product_cat_id) NOT ENFORCED
) OPTIONS(description='Hot beverage products which are for sale in Kaufland and Lidl stores e.g. coffee');