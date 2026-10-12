CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_stock_warehouse_storage_location_daily_2 (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
storage_loc_cd STRING(10) NOT NULL
OPTIONS(description='The code which identifies the storage location_2 (10001, 1002, etc)'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
active_fg BOOL OPTIONS(description='An indicator showing the current record from a business perspective,'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
blocked_stock_cnt BIGNUMERIC
OPTIONS(description='Stock of a product stored in the warehouse but currently blocked (not usable / not sellable).'),
blocked_stock_return_cnt BIGNUMERIC
OPTIONS(description='This is the stock of the customer returns, which is not used as a regular stock to sell the articles to the customers.'),
unrestricted_stock_cnt BIGNUMERIC
OPTIONS(description='An unrestricted batch is stock we can offer to a customer, and therefore is included in the ATP calculation. The status_2 is first set to unrestricted use upon receipt of a new batch. '),
restricted_stock_cnt BIGNUMERIC
OPTIONS(description='A restricted batch is stock we cannot offer to a customer, and therefore is not included in the ATP calculation.'),
in_transfer_cnt BIGNUMERIC OPTIONS(description='Stock in transfer from one storage location_2 to another'),
in_qty_inspection_cnt BIGNUMERIC
OPTIONS(description='Quality inspection stock is delivered material that is retained for quality inspection'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
PRIMARY KEY (wh_sid, storage_loc_cd, prod_variant_sid, cal_dt) NOT ENFORCED
)
OPTIONS(description='The table contains the intraday updates of available products in a stock of an particular warehouse.');