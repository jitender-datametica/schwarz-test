CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_progress_product_category_ppe (
prod_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
meta_timestamp TIMESTAMP OPTIONS(description='The meta timestamp indicated in source data.'),
prod_category_ppe_name STRING(250)
OPTIONS(description='The name of the PPE category which the product has been automatically assigned (Profilierung / Pflicht / Ergänzung).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_sid) NOT ENFORCED
)
OPTIONS(description='A new categorization of products is available for the Online Shop in all countries, where products can be assigned to one of three categories: Profilierung, Pflicht, or Ergänzung. This categorization is not obligatory.                          Source: Progress');