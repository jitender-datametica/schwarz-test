/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_STOCK_WAREHOUSE_DAILY_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 8. März 2023 16:54:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_stock_warehouse_daily_2 (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
active_fg BOOL OPTIONS(description='An indicator showing the current record from a business perspective,'),
avail_to_promise_cnt BIGNUMERIC
OPTIONS(description='The amount of stock which is currently available within the specific warehouse.            All of the stock can be sold within the onlineshop and is stored in an internal warehouse.'),
avail_to_sell_cnt BIGNUMERIC
OPTIONS(description='Available for Sale is the high level rack\'s and pick-area\'s stock within the system.'),
receiv_on_dock_cnt BIGNUMERIC
OPTIONS(description='"Received on dock" is the incoming goods area\'s stock within the system. In case of a new delivery the stock would be stated first as ROD.'),
in_transit_cnt BIGNUMERIC
OPTIONS(description='Thies field describes products/ articles which are in a transit between a warehouse and another. The TRAME builds up the Stock which is palnt to be delivert for a product to a warehouse.'),
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
total_stock_cnt BIGNUMERIC
OPTIONS(description='The sum of (blocked_stock_cnt,blocked_stock_return_cnt,unrestricted_stock_cnt,restricted_stock_cnt,in_transfer_cnt and in_qty_inspection_cnt)'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, prod_variant_sid, cal_dt) NOT ENFORCED
)
OPTIONS(description='The table contains the daily updates of available products in a stock of an particular warehouse .');