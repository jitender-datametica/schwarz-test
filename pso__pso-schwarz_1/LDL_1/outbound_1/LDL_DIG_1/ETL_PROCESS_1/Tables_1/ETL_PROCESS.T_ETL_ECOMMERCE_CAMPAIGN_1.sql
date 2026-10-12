/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_ECOMMERCE_CAMPAIGN_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. März 2024 11:58:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_ecommerce_campaign_1 (
valid_time_key_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp when campaign page was updated in the source system.'),
campaign_page_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The campaign page identifier from source system'),
prod_nr STRING(20) NOT NULL
OPTIONS(description='The number for internal onlineshop product, which is country_1 independent.'),
campaign_page_name STRING(200) OPTIONS(description='The name of the campaign page.'),
top_navigation_name STRING(200) OPTIONS(description='The name in the top navigation.'),
subtitle_txt STRING(200) OPTIONS(description='Subtitles for the promotion page.'),
url_txt STRING(200) OPTIONS(description='URL for the promotion page.'),
campaign_start_tmsp DATETIME OPTIONS(description='The timestamp when the campaign starts.'),
campaign_finish_tmsp DATETIME OPTIONS(description='The timestamp when the campaign ends.'),
country_cd STRING(5) OPTIONS(description='The unique code for the country.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (valid_time_key_tmsp, campaign_page_id, prod_nr) NOT ENFORCED
)
OPTIONS(description='ETL table that shows the data about the promotional campaign pages and the products that participate in those campaigns. Campaign Pages are the offer pages with the current weekly only store, only online and store & online offers. They normally change every week.                          ');