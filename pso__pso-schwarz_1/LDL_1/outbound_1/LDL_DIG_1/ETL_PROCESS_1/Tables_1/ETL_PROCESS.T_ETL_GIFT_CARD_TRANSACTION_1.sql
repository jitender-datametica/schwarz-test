CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_gift_card_transaction_1 (
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
cust_order_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier  for customer order ( can be return or intercompany order)'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
lidl_gift_card_nr STRING(30) NOT NULL OPTIONS(description='The unique identifier or number of the gift card used'),
lidl_gift_card_ean_nr STRING(13) OPTIONS(description='Ean_1 number of the Gift Card'),
lidl_gift_card_type_cd STRING(10)
OPTIONS(description='Code identifying the type of gift card (e.g.,\'LGK\' - Lidl Gift Card,\'ENT\' - Gift Card,\'UNENT\' - Voucher,\'MA\' - Employee_1 Card,\'SONSTIGE\' - Social Card.).'),
lidl_gift_card_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='The value of the Gift Card in gross local currency'),
dwh_created_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_order_sid, lidl_gift_card_nr) NOT ENFORCED
)
OPTIONS(description='This staging table captures granular details of Lidl Gift Card usage transactions for customer orders. The primary function of this data is to identify orders where a gift card was applied, allowing correctly determine and record the original gross selling price before the gift card reduction.             Source: SAP table: ZSDT_LGK_TRAN');