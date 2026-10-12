/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_CUSTOMER_ORDER_WEB_TRACKING_2
   GENERATED FROM POWERDESIGNER ON Freitag, 8. Juli 2022 14:32:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_customer_order_web_tracking_2 (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2'),
web_app_type_name STRING(100) NOT NULL
OPTIONS(description='Name of the web app/client type (iOS App / Android App / Mobile Web / Desktop Web ...) '),
cust_order_nr STRING(20) NOT NULL OPTIONS(description='The original order number of the source system'),
cust_order_hash_nr STRING(2000) OPTIONS(description='The hashed order number for web tracking'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated'),
dwh_src_file_name STRING(1000)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, web_app_type_name, cust_order_nr) NOT ENFORCED
)
OPTIONS(description='The relation table to hold the mapping between original customer order number to hashed value of customer order from Big Query source for tracking');