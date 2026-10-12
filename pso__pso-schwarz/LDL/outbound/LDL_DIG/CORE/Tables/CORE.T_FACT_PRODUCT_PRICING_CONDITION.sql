/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_PRODUCT_PRICING_CONDITION
   GENERATED FROM POWERDESIGNER ON Dienstag, 31. Mai 2022 08:00:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_product_pricing_condition (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
price_type_cd STRING(20) NOT NULL
OPTIONS(description='Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc'),
price_group_cd STRING(20) OPTIONS(description='Code of pricing group - internal or customer facing'),
active_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The first date from when this record became valid from a business perspective,'),
active_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The last date up to when this record was valid from a business perspective,'),
curr_cd STRING(5) OPTIONS(description='Currency in which target is set'),
price_val BIGNUMERIC(38,5) OPTIONS(description='Valid price in given currency'),
price_change_reason_cd STRING(5)
OPTIONS(description='The code for the price change reason ( profit/loss reason   like  001, 327, 326... etc)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
PRIMARY KEY (prod_variant_sid, wshop_cd, price_type_cd, active_from_tmsp) NOT ENFORCED
) OPTIONS(description='This fact defines the price catalog for lidl internal and customer facing prices.');