CREATE OR REPLACE TABLE szd_production_etl.t_etl_fact_hga_sales_per_hour_2 (
hga_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store'),
hga_product_cat_id INTEGER NOT NULL OPTIONS(description='The code for a hot beverage product'),
sale_hour INTEGER NOT NULL OPTIONS(description='The hour for a hot beverage product sale'),
sale_dt DATE NOT NULL OPTIONS(description='The calendar_2 date of the hot beverage sales_2 '),
product_sale_cnt INTEGER NOT NULL OPTIONS(description='The number of hot beverage product sales_2 per hour'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (hga_sid, sale_hour, sale_dt, hga_product_cat_id) NOT ENFORCED
);