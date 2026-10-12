CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_product_utilisation_1 (
prod_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
util_action_cd STRING(20) NOT NULL
OPTIONS(description='The unique code for  the way the product goes under utilisaton (Utilisation,  Discontinuation etc)'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
exception_util_dt DATE
OPTIONS(description='We have specific Utilization dates for articles, which can change from time to time. This is case then the utilization date gets replaced with a new one.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_1 independent'),
PRIMARY KEY (prod_sid, dwh_valid_from_tmsp, util_action_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the way the product gets utilised');