DROP TABLE IF EXISTS ldl_data_production_core_app_fraud_detection.t_cash_register_print_1;
CREATE OR REPLACE TABLE ldl_data_production_core_app_fraud_detection.t_cash_register_print_1 (
cash_register_event_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.'),
cash_register_event_nr STRING(20) NOT NULL
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_1-cycled after some time.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
cash_register_event_line_seq INTEGER NOT NULL
OPTIONS(description='The number of the line in the retail event, in the case of the techical event or price information event is the value always\""-1\""'),
event_auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operation, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
parent_line_seq INTEGER NOT NULL
OPTIONS(description='In case the line represents a deposit, this is the related base line.'),
cash_register_event_scenario_id INTEGER NOT NULL
OPTIONS(description='The code identifying all kinds of cash register event (technical or retail event).'),
retail_event_line_scenario_id INTEGER
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event line.'),
event_start_tmsp TIMESTAMP OPTIONS(description='The point in time when the retail event started.'),
event_end_tmsp TIMESTAMP OPTIONS(description='The end timestamp of the retail event.'),
event_line_start_tmsp TIMESTAMP
OPTIONS(description='The point in time when the retail event line started.'),
event_line_end_tmsp TIMESTAMP OPTIONS(description='The end timestamp of the retail event line.'),
bus_dt DATE OPTIONS(description='The business date on which the retail event is counted.'),
store_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
store_nr STRING(20) OPTIONS(description='The identifier for the store where the related retail event happend.'),
country_org_cd STRING(2)
OPTIONS(description='The code of the related business country. (The business country_1 is not identical to a political country.)'),
cash_register_nr STRING(20) OPTIONS(description='The number which identifies the cash register.'),
prod_retail_line_type_cd STRING(20)
OPTIONS(description='The code identifying the subtype discriminator for product retail lines.'),
prod_variant_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for a sales_1 variant of a product.'),
local_prod_nr STRING(100)
OPTIONS(description='The number which identifies the product in the operational retail management system within the given market / internal organization (i.e. the local item_1 number).  Note that the product number is unique for a certain point in time, but may be re_1-used later on. One product may be identified by several numbers in case of parallel listings or rolling listings. This is the number which has been configured in the cash registers of the given stores for the point in time when the retail transaction was made.'),
prod_variant_input_nr STRING(100)
OPTIONS(description='The number which identifies the product variant - as it has been scanned or manually keyed this. This can be an EAN_1, GTIN or a price lookup number (PLU)'),
prod_variant_input_nr_type_cd STRING(20)
OPTIONS(description='The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN_1, a GTIN or a product lookup number (PLU).'),
prod_name STRING(250) OPTIONS(description='The name of the global product, which is the base for this sales_1 variant.'),
prod_entry_method_cd STRING(20)
OPTIONS(description='The code identifying the way, how the product was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
price_entry_method_cd STRING(20)
OPTIONS(description='The code identifying the way, how the unit_1 price was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
paym_line_type_cd STRING(20)
OPTIONS(description='The code identifying the subtype discriminator for payment lines. It distinguishes between incoming and outgoing payments, i.e. payments made by the customer and payments made to the customer.'),
paym_type_id INTEGER OPTIONS(description='The identifier for the way of payment, i.e. cash, card, voucher, etc.'),
fraud_detection_relevant_fg BOOL OPTIONS(description='The identifier of fraud detection relevant receipts.'),
prod_return_reason_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for the reasons why a product was returend to the store.'),
return_txt STRING(1000) OPTIONS(description='A free text field describing the circumstances of the return.'),
parent_retail_event_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_1 or return of products..'),
discount_fg BOOL
OPTIONS(description='An indicator showing, if a discount or a price modification was applied to the product.'),
unit_price NUMERIC(29,5)
OPTIONS(description='The price of a single unit_1 of the product variant, in the currency indicated by the currency code.'),
prod_variant_cnt INTEGER
OPTIONS(description='The number of this product variant which has been sold or returned. (This attribute is empty for weight-based products.)'),
prod_variant_qty NUMERIC(29,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the product which was sold or returned.'),
base_gross_val NUMERIC(29,5)
OPTIONS(description='The base gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts or price modifications are not considered.'),
retail_line_gross_val NUMERIC(29,5)
OPTIONS(description='The gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered.'),
retail_line_vat_val NUMERIC(29,5)
OPTIONS(description='The total amount of value added tax which was charged for this line.'),
local_paym_val NUMERIC(29,5)
OPTIONS(description='The amount which was paid in local currency. If the amount was paid by the customer, the sign is positive. If the amount was paid to the customer, the sign is negative. If the payment was in a foreign currency, this is the local currency equivalent.'),
tax_pct NUMERIC(29,5)
OPTIONS(description='The actual tax percentage which is valid for the given tax class. E.g. 19% and also for the products which got sold.'),
cash_register_event_seq INTEGER NOT NULL
OPTIONS(description='Is a sequence number partition by: real_estate_sid ,bus_dt ,cashier_hash and order by event_end_tmsp.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
line_auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operation, the transaction line must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction line. (This is not an employee_1 number!)'),
orig_country_org_cd STRING(2)
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this column contains the country_1 information of the original receipt.'),
orig_store_nr STRING(20)
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the store number of the original receipt.'),
orig_bus_dt DATE
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the business date of the original receipt.'),
orig_cash_register_nr INTEGER
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the cash register number of the original receipt.'),
orig_cash_register_event_nr INTEGER
OPTIONS(description='In case of the return the customer needs to provide the original receipt, this columns contains the cash register number of the original receipt.'),
first_line_of_event_fg BOOL NOT NULL
OPTIONS(description='Displays the first line of the receipt. Due to the sitaution that sometimes we receive lines with number\""0\"". '),
tax_line_gross_val NUMERIC(29,5)
OPTIONS(description='That is the base gross value, which is the base for the VAT calculation.'),
tax_line_val NUMERIC(29,5) OPTIONS(description='The resulting tax amount.'),
PRIMARY KEY (cash_register_event_sid, cash_register_event_line_seq, parent_line_seq) NOT ENFORCED
) CLUSTER BY bus_dt
OPTIONS(description='Keeps the cash register events which are identificated for fraud detection and pre- and post receipts for printout.');