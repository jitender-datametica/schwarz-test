/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_STOCK_KNOCKDOWN_1
   GENERATED FROM POWERDESIGNER ON Montag, 6. Mai 2024 16:54:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_stock_knockdown_1 (
knockdown_posting_dt DATE NOT NULL OPTIONS(description='Date when the posting(booking) in accounting system was made'),
knockdown_dt DATE NOT NULL OPTIONS(description='Date at which the loss of value takes effect.'),
prod_variant_sid BIGNUMERIC NOT NULL OPTIONS(description='Surrogate key for the Product Variant'),
internal_company_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the company'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
internal_company_cd STRING(5)
OPTIONS(description='Unique identifier of the company to which we book accounting documents in the source system (SAP)'),
first_inbound_dt DATE
OPTIONS(description='Earliest posting date in material movement document for each Product Variant.'),
stock_knockdown_category_cd STRING(20)
OPTIONS(description='	A code of the category of value knock-down (a.k.a  write-down or devaluation of asset). Categories are based on how long stock remained in the warehouse and how much items were sold.'),
knockdown_stock_cnt BIGNUMERIC
OPTIONS(description='How many of the stock items stored in the warehouse, lost part of their value'),
total_stock_cnt BIGNUMERIC
OPTIONS(description='The total stock of the product variant -how many items of the product variant are stored in the warehouse'),
total_stock_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total value (before the knockdown process) of all items for this product variant that are  present in stock (independently if they are considered for knockdown or not)'),
unit_stock_knockdown_eval_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Base price per single unit_1 of the Product Variant - before the knockdown. Used to evaluate the stock (It is the smallest price assigned to a product variant (between GLD/IVP/EKP/VKP) at the knockdown_dt) '),
total_stock_knockdown_eval_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total value of the items considered for knockdown in stock of the Product Variant (equals to KNOCKDOWN_STOCK_CNT *  UNIT_STOCK_KNOCKDOWN_EVAL_NET_EUR_VAL).             This amount will be written off from TOTAL_STOCK_NET_EUR_VAL to get the new value of all items in stock after the depreciation'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (knockdown_posting_dt, knockdown_dt, prod_variant_sid, internal_company_sid) NOT ENFORCED
)
OPTIONS(description='ETL table that helps loading T_FACT_STOCK_KNOCKDOWN. Main source is SAP             The table contains data for items that are in stock (within the warehouses) and their prices have to be reduced.              In GERMAN - RWA. Means Reichweitenabschlag -> English: stock_knockdown -> value reduction of unsold stock based on the time spent in the warehouse                          The granularity of the table is Prod Variant (what assests are depreciated), Knockdown Date (on which date the assets value depreciated ), Knockdown Posting DT (on which date the record for stock depreciation was posted in the accounting system) and Internal Company (which company owns the assests that are losing value). As of April 2024, all stock is owned by Lidl Dig Trading GmbH&Co, which means the only value in INTERNAL_COMPANY_CD will be D888');