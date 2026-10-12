CREATE OR REPLACE TABLE ldl_dig_production_core.t_dim_supplier (
supplier_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for supplier'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
supplier_nr STRING(20) OPTIONS(description='Account number of supplier/vendor from the sorce system'),
supplier_name STRING(100) OPTIONS(description='Company name of the supplier/vendor.'),
addr_sid INTEGER OPTIONS(description='Address associated with the supplier account.'),
orig_country_cd STRING(5) OPTIONS(description='Country where the supplier account is based.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
supplier_full_name STRING(100) OPTIONS(description='Full company name of the supplier/vendor.'),
zip_cd STRING(100) OPTIONS(description='A zip code of the address associated with the supplier'),
city_name STRING(100) OPTIONS(description='City name of the address associated with the supplier'),
street_name STRING(100) OPTIONS(description='The name of a street in the address associated with the supplier'),
supplier_src_insert_dt DATE OPTIONS(description='Date when the supplier was added to the ERP system.'),
PRIMARY KEY (supplier_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='Supplier ( lieferant )');