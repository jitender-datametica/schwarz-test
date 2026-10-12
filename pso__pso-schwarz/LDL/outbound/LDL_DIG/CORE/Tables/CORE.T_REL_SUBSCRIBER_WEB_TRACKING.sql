/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUBSCRIBER_WEB_TRACKING
   GENERATED FROM POWERDESIGNER ON Dienstag, 14. Juni 2022 11:49:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_subscriber_web_tracking (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
web_app_type_name STRING(100) NOT NULL
OPTIONS(description='Name of the web app/client type (iOS App / Android App / Mobile Web / Desktop Web ...) '),
tracking_token_nr STRING(2000) NOT NULL
OPTIONS(description='A string that is inserted in email allowing the tracking of subscriber activities'),
tracking_token_hash_nr STRING(2000)
OPTIONS(description='The hashed string value that is inserted in email allowing the tracking of subscriber activities'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated'),
dwh_src_file_name STRING(1000)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, web_app_type_name, tracking_token_nr) NOT ENFORCED
)
OPTIONS(description='The mapping table to hold the original token to hashed token number of subscriber for webtracking');