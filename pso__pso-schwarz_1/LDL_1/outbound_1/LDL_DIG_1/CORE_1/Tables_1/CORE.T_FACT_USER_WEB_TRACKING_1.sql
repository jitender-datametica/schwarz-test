/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_USER_WEB_TRACKING_1
   GENERATED FROM POWERDESIGNER ON Montag, 28. November 2022 13:00:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_user_web_tracking_1 (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
full_visitor_id STRING(500) NOT NULL OPTIONS(description='The visitor id generated in big query'),
client_id STRING(500) NOT NULL OPTIONS(description='The client id generated in google analytics'),
cust_hash_nr STRING(2000) NOT NULL OPTIONS(description='The hashed customer number for tracking'),
tracking_token_hash_nr STRING(2000) NOT NULL
OPTIONS(description='The hashed string value of token id in email allowing the tracking of subscriber activities'),
user_visit_dt DATE NOT NULL OPTIONS(description='The date when the user visited the site'),
user_visit_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The start timestamp when the user has visited the site'),
user_click_type STRING(250)
OPTIONS(description='The user click tracking type to identify if google ad/ facebook or google double click'),
user_click_id STRING(2000) OPTIONS(description='The unique click identifier created as a tracking parameter'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated'),
dwh_src_file_name STRING(1000)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, full_visitor_id, client_id, cust_hash_nr, tracking_token_hash_nr, user_visit_dt,
 user_visit_start_tmsp) NOT ENFORCED
) OPTIONS(description='The fact table that holds the tracking information of the user on web');