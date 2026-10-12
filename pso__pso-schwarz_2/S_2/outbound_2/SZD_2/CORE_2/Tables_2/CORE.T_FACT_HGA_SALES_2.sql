/* --------------------------------------------------------------------------------
   DDL for table: t_fact_hga_sales_2
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:40:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_hga_sales_2 (
hga_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store'),
sale_dt DATE NOT NULL OPTIONS(description='The calendar_2 date of the hot beverage sales_2 '),
sale_tm TIME NOT NULL OPTIONS(description='The time for the hot beverage sale'),
payment_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The identifier for the payment type for a hot beverage'),
hga_product_cat_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The code for a hot beverage product'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
mug_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The identifier for a chosen mug type'),
sale_price BIGNUMERIC(38,5) NOT NULL OPTIONS(description='The price for a hot beverage product in national currency'),
sale_eur_price BIGNUMERIC(38,5) NOT NULL OPTIONS(description='The price for a hot beverage product in euro'),
lid_fg BOOL NOT NULL OPTIONS(description='An indicator showing if the customer choose a lid or not'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (hga_sid, sale_dt, sale_tm) NOT ENFORCED
)
OPTIONS(description='Transactional facts capturing hot beverage product sales_2 of hot beverage machines located in stores');