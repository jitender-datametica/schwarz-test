CREATE OR REPLACE TABLE smp_production_etl_process.t_smp_taxonomy_base_exception_2 (
division_id STRING(100) NOT NULL,
country_id STRING(100) NOT NULL,
division_country_ref INTEGER,
article_id_ref INTEGER,
gtin_id STRING(500),
day_start_dt DATE,
day_end_dt DATE,
article_name STRING(500) COLLATE 'und:ci',
article_name_country STRING(500) COLLATE 'und:ci',
article_id INTEGER,
article_parent_id INTEGER,
taxonomy_attributes ARRAY < STRING >,
retailer_id STRING(118),
load_timestamp DATETIME
) OPTIONS(description='Exception articles for positivlist');