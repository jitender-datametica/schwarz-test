CREATE TABLE IF NOT EXISTS ldl_dig_core.t_agg_google_analytics_daily_summary_1 (
cal_dt DATE NOT NULL OPTIONS(description='Date when statistics were tracked'),
country_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for a country_1 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
web_app_type_name STRING(100) NOT NULL
OPTIONS(description='The unique identifier (Name)  for type of App( Client)  used to access the Lidl webshop'),
ga_src_name STRING(5) NOT NULL OPTIONS(description='The code for the the source of google analytics (WEB or APP)'),
utm_source_name STRING(100) NOT NULL
OPTIONS(description='Identifies which site sent the traffic (reffered to the Webshop site)'),
utm_medium_name STRING(100) NOT NULL
OPTIONS(description=' Identifies what type of link was used to refer to the webshop'),
visit_all_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Count of visits'),
transaction_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Count of transactions'),
revenue_gross_eur_val BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Total revenue in euro'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated'),
dwh_src_file_name STRING(1000)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cal_dt, country_cd, web_app_type_name, ga_src_name, utm_source_name, utm_medium_name) NOT ENFORCED
)
OPTIONS(description='A daily summary for google analytics stats (visits, transactions, net spent). Granularity is one row per Day, Country_1, Touchpoint (program used for access), Web_app (browser or app) , Source (UTM_source + UTM_medium)');