/* --------------------------------------------------------------------------------
   DDL for table: t_fact_hga_sales_per_hour_1
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:41:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_hga_sales_per_hour_1 (
hga_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store'),
sale_hour BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The hour for a hot beverage product sale'),
sale_dt DATE NOT NULL OPTIONS(description='The calendar_1 date of the hot beverage sales_1 '),
hga_product_cat_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The code for a hot beverage product'),
product_sale_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number of hot beverage product sales_1 per hour'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (hga_sid, sale_hour, sale_dt, hga_product_cat_id) NOT ENFORCED
)
OPTIONS(description='Aggregated facts capturing Hot beverage product sales_1 per hour of hot beverage machines located in stores');