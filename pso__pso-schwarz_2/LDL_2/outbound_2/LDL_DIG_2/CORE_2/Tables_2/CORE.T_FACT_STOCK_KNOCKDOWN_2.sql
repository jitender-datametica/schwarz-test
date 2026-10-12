/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_STOCK_KNOCKDOWN_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 30. Juli 2024 10:02:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_stock_knockdown_2 (
knockdown_dt DATE NOT NULL OPTIONS(description='Date at which the loss of value takes effect.'),
prod_variant_sid BIGNUMERIC NOT NULL OPTIONS(description='Surrogate key for the Product Variant'),
internal_company_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the company'),
internal_company_cd STRING(5)
OPTIONS(description='Unique identifier of the company to which we book accounting documents in the source system (SAP)'),
bus_year BIGNUMERIC OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'),
month_of_bus_year BIGNUMERIC
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
prod_sid BIGNUMERIC OPTIONS(description='The surrogate key for the main product'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_2 independent'),
first_inbound_dt DATE
OPTIONS(description='Earliest posting date in material movement document for each Product Variant.'),
stock_knockdown_category_cd STRING(20)
OPTIONS(description='	A code of the category of value knock-down (a.k.a  write-down or devaluation of asset). Categories are based on how long stock remained in the warehouse and how much items were sold.'),
total_stock_cnt BIGNUMERIC
OPTIONS(description='The total stock of the product variant -how many items of the product variant are stored in the warehouse'),
knockdown_stock_cnt BIGNUMERIC
OPTIONS(description='How many of the stock items stored in the warehouse, lost part of their value'),
unit_stock_knockdown_eval_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Base price per single unit_2 of the Product Variant - before the knockdown. Used to evaluate the stock (It is the smallest price assigned to a product variant (between GLD/IVP/EKP/VKP) at the knockdown_dt) '),
total_stock_knockdown_eval_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total value of the items considered for knockdown in stock of the Product Variant (equals to KNOCKDOWN_STOCK_CNT *  UNIT_STOCK_KNOCKDOWN_EVAL_NET_EUR_VAL).             This amount will be written off from TOTAL_STOCK_NET_EUR_VAL to get the new value of all items in stock after the depreciation'),
diff_prev_total_stock_knockdown_eval_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Difference of the total value of the items considered for knockdown in stock of the Product Variant compared to the previous knockdown date'),
total_stock_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total value (before the knockdown process) of all items for this product variant that are  present in stock (independently if they are considered for knockdown or not)'),
total_stock_after_knockdown_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total value of  all stock after the depreciation process (the knockdown). '),
unit_stock_after_knockdown_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Price per single unit_2 of stock after the depreciation process (the knockdown). Calculated as TOTAL_STOCK_AFTER_KNOCKDOWN_NET_EUR_VAL / TOTAL_STOCK_CNT'),
not_blocked_stock_knockdown_eval_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total value of all non-blocked items which are in stock and considered for knockdown.( value before the knockdown)'),
diff_prev_not_blocked_stock_knockdown_eval_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Difference of the total value of all non-blocked items considered for knockdown of the Product Variant compared to the previous knockdown date'),
not_blocked_unit_stock_after_knockdown_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Price per single unit_2 of not-blocked stock after the depreciation process (the knockdown). '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (knockdown_dt, prod_variant_sid, internal_company_sid) NOT ENFORCED
)
OPTIONS(description='The table contains data for items that are in stock (within the warehouses) and their value  has to be depreciated.              In GERMAN - RWA. Means Reichweitenabschlag-> English: stock_knockdown -> value reduction of unsold stock based on the time spent in the warehouse                          The granularity of the table is Prod Variant (what assests are login their value), Knockdown Date (on which date the assets value depreciated ) and Internal Company (which company owns the assests that are losing value). As of April 2024, all stock is owned by Lidl Dig Trading GmbH&Co, which means the only value in INTERNAL_COMPANY_CD will be D888');