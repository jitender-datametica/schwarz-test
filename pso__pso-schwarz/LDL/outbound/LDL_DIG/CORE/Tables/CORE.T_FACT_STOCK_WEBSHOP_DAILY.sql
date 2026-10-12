/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_STOCK_WEBSHOP_DAILY
   GENERATED FROM POWERDESIGNER ON Donnerstag, 13. Juni 2024 15:04:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_stock_webshop_daily (
wshop_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the Lidl webshop'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31).'),
active_fg BOOL
OPTIONS(description='An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt'),
avail_to_promise_cnt BIGNUMERIC
OPTIONS(description='The amount of stock which is currently available within the specific warehouse.            All of the stock can be sold within the onlineshop and is stored in an internal warehouse. This field is obsolete and will be replaced by avail_to_sell_stock_cnt.'),
global_stock_cnt BIGNUMERIC
OPTIONS(description='Global stock represents a common pool of stock that is available for the webshops to take stock from (when their supply is not enogh) This value represents the count of given product variant in this common pool (global stock) that is available for this webshop'),
avail_to_sell_cnt BIGNUMERIC
OPTIONS(description='Available for Sale is the high level rack\'s and pick-area\'s stock within the system. This field is obsolete and will be replaced by avail_to_sell_stock_cnt.'),
receiv_on_dock_cnt BIGNUMERIC
OPTIONS(description='"Received on dock" is the incoming goods area\'s stock within the system. In case of a new delivery the stock would be stated first as ROD.'),
covered_remain_cnt BIGNUMERIC
OPTIONS(description='The amount, which the countries were actually able to reserve from the specific warehouses.            Calculation Logic: ATP - reservations (under consideration of hard and soft once and potential overbookings of other countries) -->             All of the stock can be sold within the onlineshop and is stored in an internal warehouse.'),
alloc_stock_cnt BIGNUMERIC
OPTIONS(description='The reserved stock for a country - this stock is only available for this country (for a certain time period)'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
avail_lvl_cd STRING(5)
OPTIONS(description='Indicator code for availability (1, Online ausverkauft; 2, Online in Kürze; 3, Bestellbar; Null, Offline)'),
avail_to_sell_stock_cnt BIGNUMERIC
OPTIONS(description='Stock count of the product variant available for sale on that day in the given webshop - this is the maximum product count that can be ordered in total in all customer orders placed on that day. This field is going to replace the fields avail_to_sell_cnt and avail_to_promise_cnt.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, prod_variant_sid, cal_dt) NOT ENFORCED
) OPTIONS(description='The table contains the daily updates of available products to sell in particular webshop.');