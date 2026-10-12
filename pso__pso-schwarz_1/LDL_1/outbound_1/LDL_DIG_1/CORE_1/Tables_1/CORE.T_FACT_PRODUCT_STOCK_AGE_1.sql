CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_product_stock_age_1 (
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
active_fg BOOL OPTIONS(description='An indicator showing the current record from a business perspective'),
prod_stock_age_cluster_cd STRING(5)
OPTIONS(description='A code for aggregation of product stock into age clusters to define how long products have been stored in our warehouse.'),
ref_booking_dt DATE OPTIONS(description='The date when the booking reference has been made'),
first_inbound_dt DATE
OPTIONS(description='Min posting date in material movement document for each Product Variant. For Product Level (head level) it is considered the Min date for all the Product Variants. '),
delta_day_cnt BIGNUMERIC OPTIONS(description='The count of delta days'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
PRIMARY KEY (prod_variant_sid, cal_dt) NOT ENFORCED
)
OPTIONS(description='The fact  table with product clustering to facilitate stock utilisation  based on how long products have been stored in our warehouse. ');