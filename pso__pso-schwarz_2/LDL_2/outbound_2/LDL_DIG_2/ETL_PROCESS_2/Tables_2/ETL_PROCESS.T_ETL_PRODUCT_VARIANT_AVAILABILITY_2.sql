/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_PRODUCT_VARIANT_AVAILABILITY_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 15. November 2023 14:29:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_product_variant_availability_2 (
meta_timestamp TIMESTAMP NOT NULL OPTIONS(description='The meta timestamp'),
meta_language STRING(20) NOT NULL OPTIONS(description='The meta language'),
meta_erp_number STRING(20) NOT NULL OPTIONS(description='The meta erp number'),
meta_event_type STRING(50) NOT NULL OPTIONS(description='The meta event type'),
orig_meta_tmsp TIMESTAMP
OPTIONS(description='The timestamp when last time information about product variant was updated'),
meta_mindshift_event_type_id STRING(250) OPTIONS(description='The identifier of meta mindshift event type'),
meta_catalog STRING(20) OPTIONS(description='The meta catalog'),
meta_type STRING(250) OPTIONS(description='The meta type'),
meta_item_category STRING(20) OPTIONS(description='The meta item_2 category'),
dwh_deleted BOOL OPTIONS(description='Flag to indicate dwh deletion'),
product_id STRING(50) OPTIONS(description='The product identifier'),
erp_number STRING(20) OPTIONS(description='The erp number'),
onstock BOOL OPTIONS(description='The onstock indicator'),
total_stock BIGNUMERIC(38,0) OPTIONS(description='The total stock count'),
availability_indicator STRING(10) OPTIONS(description='The availability indicator'),
back_in_stock_notification BOOL OPTIONS(description='The notification indicator for back in stock'),
max_order_quantity BIGNUMERIC(38,0) OPTIONS(description='The maximum order quantity'),
min_order_quantity BIGNUMERIC(38,0) OPTIONS(description='The minimum order quantity'),
graduation_quantity BIGNUMERIC(38,0) OPTIONS(description='The graduation quantity'),
sap_status STRING(10) OPTIONS(description='The sap status_2'),
article_status STRING(50) OPTIONS(description='The article status_2'),
eci_article_status STRING(50) OPTIONS(description='The eci article status_2'),
listing_status STRING(50) OPTIONS(description='The listing status_2'),
status_global STRING(20) OPTIONS(description='The global status_2'),
status_global_code STRING(20) OPTIONS(description='The code for global status_2'),
status_global_desc STRING(20) OPTIONS(description='The description of global status_2'),
status_listing STRING(20) OPTIONS(description='The status_2 listing'),
status_listing_code STRING(20) OPTIONS(description='The code for status_2 listing'),
status_listing_desc STRING(20) OPTIONS(description='The description for status_2 listing'),
status_online STRING(20) OPTIONS(description='The online status_2'),
status_online_code STRING(20) OPTIONS(description='The code for online status_2'),
status_online_desc STRING(20) OPTIONS(description='The desription for online status_2'),
status_online_actual STRING(20) OPTIONS(description='The actual online status_2'),
status_display_storefront STRING(50) OPTIONS(description='The status_2 display of store front'),
in_online_catalog BOOL OPTIONS(description='An indicator for online catalog'),
was_in_online_catalog BOOL OPTIONS(description='An indicator to show if was already in online catalog'),
indexing_search_engines BOOL OPTIONS(description='The indexing search engine'),
export_branch_terminal BOOL OPTIONS(description='The export branch terminal'),
export_price_engines BOOL OPTIONS(description='The export price engine'),
url STRING(250) OPTIONS(description='The url reference'),
online_fg BOOL OPTIONS(description='Online indicator'),
store BOOL OPTIONS(description='Store indicator'),
internet_only BOOL OPTIONS(description='Internat only indicator'),
eciavailableinonline BOOL OPTIONS(description='eciAvailableInOnline indicator'),
available_in_store BOOL OPTIONS(description='available_in_store indicator'),
available_in_store_from TIMESTAMP OPTIONS(description='available_in_store_from timestamp'),
available_in_store_until TIMESTAMP OPTIONS(description='available_in_store_until timestamp'),
ean_2 STRING(20) OPTIONS(description='european article number'),
online_date DATE OPTIONS(description='Online date'),
prevent_selling_fg BOOL OPTIONS(description='Indicates if product is prevented from selling'),
content_classification_rating STRING(20)
OPTIONS(description='This is a Lidl specific rating which expresses the level of content a certain article has and is created with. We differentiate between Discount, Standard & Premium content (or n/a) to specify how much content an article has in the web shop. The higher the rating the more information & content features are added to the article on its page.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (meta_timestamp, meta_language, meta_erp_number) NOT ENFORCED
)
OPTIONS(description='The table mimics the structure of T_ETL_PROGRESS_PRODUCT_CATALOG. But here, there are no gaps in dates and the table will be delta updated (taking only those rows from t_etl_progress_product_catalog_2 that were changed in the last few days). There will be no duplicates as well.');