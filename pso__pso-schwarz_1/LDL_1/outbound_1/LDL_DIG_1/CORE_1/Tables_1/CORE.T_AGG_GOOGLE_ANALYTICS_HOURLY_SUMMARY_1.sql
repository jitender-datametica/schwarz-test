CREATE TABLE IF NOT EXISTS ldl_dig_core.t_agg_google_analytics_hourly_summary_1 (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
cal_dt DATE NOT NULL,
cal_tm TIME NOT NULL,
ga_src_name STRING(5) NOT NULL OPTIONS(description='The name for the the source of google analytics (WEB or APP)'),
user_cnt_val BIGNUMERIC(38,5),
session_cnt_val BIGNUMERIC(38,5),
transaction_cnt_val BIGNUMERIC(38,5),
unique_page_view_cnt_val BIGNUMERIC(38,5),
sessions_per_user_cnt_val BIGNUMERIC(38,5),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, cal_dt, cal_tm, ga_src_name) NOT ENFORCED
);