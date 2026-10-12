CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_product_price_supplier_regional_2 (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2'),
condition_number_cd STRING(20),
purch_org_type_cd STRING(8) NOT NULL,
supplier_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for supplier_2'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
price_type_cd STRING(20) NOT NULL
OPTIONS(description='Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc'),
price_group_cd STRING(20) OPTIONS(description='Code of pricing group - internal or customer facing'),
active_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The first date from when this record became valid from a business perspective,'),
active_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The last date up to when this record was valid from a business perspective,'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, purch_org_type_cd, prod_variant_sid, supplier_sid, price_type_cd, active_from_tmsp) NOT ENFORCED
)
OPTIONS(description='ETL Support table -  fact for prices on supplier_2 level (Purchase price, Additional freight costs, etc)');