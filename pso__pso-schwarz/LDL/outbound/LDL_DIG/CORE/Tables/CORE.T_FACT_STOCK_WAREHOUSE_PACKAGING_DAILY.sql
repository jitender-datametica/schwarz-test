CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_stock_warehouse_packaging_daily (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
storage_loc_cd STRING(10) NOT NULL
OPTIONS(description='The code which identifies the storage location (10001, 1002, etc)'),
pack_material_nr STRING(20) NOT NULL OPTIONS(description='The packaging material number (e..g 420000026,  420000028)'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
active_fg BOOL OPTIONS(description='An indicator showing the current record from a business perspective,'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
blocked_stock_cnt BIGNUMERIC
OPTIONS(description='Stock of a product stored in the warehouse but currently blocked (not usable / not sellable).'),
unrestricted_stock_cnt BIGNUMERIC
OPTIONS(description='An unrestricted batch is stock we can offer to a customer, and therefore is included in the ATP calculation. The status is first set to unrestricted use upon receipt of a new batch. '),
restricted_stock_cnt BIGNUMERIC
OPTIONS(description='A restricted batch is stock we cannot offer to a customer, and therefore is not included in the ATP calculation.'),
in_transfer_cnt BIGNUMERIC OPTIONS(description='Stock in transfer from one storage location to another'),
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
PRIMARY KEY (wh_sid, storage_loc_cd, pack_material_nr, cal_dt) NOT ENFORCED
)
OPTIONS(description='The table contains the intraday updates of available products in a stock of an particular warehouse.');