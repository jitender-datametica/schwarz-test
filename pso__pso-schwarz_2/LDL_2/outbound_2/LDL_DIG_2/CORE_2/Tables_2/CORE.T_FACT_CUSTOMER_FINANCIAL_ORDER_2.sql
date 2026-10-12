/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_CUSTOMER_FINANCIAL_ORDER_2
   GENERATED FROM POWERDESIGNER ON Montag, 18. November 2024 14:26:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_customer_financial_order_2 (
wshop_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the Lidl webshop'),
cust_order_install_nr STRING(20) NOT NULL
OPTIONS(description='Per customer order there is one payment order, original number can be reused'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
debt_collection_status_cd STRING(5)
OPTIONS(description='The code for the status_2 of the debt collection process. e.g. 01 = Receivable Released For Submission, 02 = Receivable Submitted, 12 = Receivable Cleared etc. '),
debt_collection_start_dt DATE OPTIONS(description='Start date of debt collection'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (wshop_cd, cust_order_install_nr, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='For every customer order there is an internal financial order created by lidl. ( a header table to support the ETL process)');