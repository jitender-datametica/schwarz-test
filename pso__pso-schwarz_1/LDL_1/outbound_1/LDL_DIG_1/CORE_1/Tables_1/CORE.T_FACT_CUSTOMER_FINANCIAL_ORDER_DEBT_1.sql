/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_CUSTOMER_FINANCIAL_ORDER_DEBT_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 28. September 2022 14:00:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_customer_financial_order_debt_1 (
cust_order_install_nr STRING(20) NOT NULL
OPTIONS(description='Per customer order there is one payment order, original number can be reused'),
debt_collection_item_nr BIGNUMERIC NOT NULL
OPTIONS(description='The collection item_1 number related to the payment order that goes to debt collection process (Inkasso).(referred to one or multiple payment order positions assigned to debt collection process)'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
cust_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for the customer (to whom the debt collection process relates)'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
debt_collection_request_local_val BIGNUMERIC(38,5)
OPTIONS(description='Open amount to be collected in the Inkasso process by a collection agency when the customer has ignored the payment requests. '),
debt_collection_paid_local_val BIGNUMERIC(38,5)
OPTIONS(description='Amount collected in the Inkasso process  by a collection agency  when the customer has ignored the payment requests(can be paid via collection agency or directly to Lidl)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (cust_order_install_nr, debt_collection_item_nr, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='The fact table holding the debt collection item_1 details ');