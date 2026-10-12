/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_PRODUCT_VARIANT_REL
   GENERATED FROM POWERDESIGNER ON Montag, 13. Mai 2024 11:23:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_product_variant_rel (
primary_src_name STRING(100) NOT NULL OPTIONS(description='The name of the primary source system.'),
primary_prod_variant_nr STRING(100) NOT NULL OPTIONS(description='Product variant number from the primary source.'),
secondary_src_name STRING(100) NOT NULL OPTIONS(description='The name of the secondary source system.'),
secondary_prod_variant_nr STRING(100) NOT NULL OPTIONS(description='Product variant number from the secondary source.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (primary_src_name, primary_prod_variant_nr, secondary_src_name, secondary_prod_variant_nr) NOT ENFORCED
)
OPTIONS(description='An ETL table that relates natural keys for product variants (prod_variant_nr) between different source systems.');