/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_CUSTOMER_WEB_TRACKING
   GENERATED FROM POWERDESIGNER ON Freitag, 8. Juli 2022 13:26:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_customer_web_tracking (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
web_app_type_name STRING(100) NOT NULL
OPTIONS(description='Name of the web app/client type (iOS App / Android App / Mobile Web / Desktop Web ...) '),
cust_nr STRING(20) NOT NULL OPTIONS(description='The customer number from original system'),
cust_acct_id STRING(100) NOT NULL
OPTIONS(description='The account identifier which is SHA256 hash value to identify the SAP customer number'),
cust_hash_nr STRING(2000) OPTIONS(description='The hashed customer number for tracking'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated'),
dwh_src_file_name STRING(1000)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, web_app_type_name, cust_nr, cust_acct_id) NOT ENFORCED
)
OPTIONS(description='The relation table to hold the mapping between original customer number to hashed value customer number from Big Query source for tracking');