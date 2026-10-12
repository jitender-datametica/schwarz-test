CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_tcache_pos_receipt_load_keyed_utcc_2_product_retail_line___set_a_2 (
retail_event_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_2 or return of products..'),
retail_event_line_seq INTEGER NOT NULL OPTIONS(description='The number of the line in the retail event.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the scanning (or the manual input) of the article started.'),
event_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the scanning (or the manual input) of the article was finished.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
retail_event_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the related retail event was finished.'),
store_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country_2 is not identical to a political country.)'),
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
cash_register_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operation, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_2, who has authorized the transaction. (This is not an employee_2 number!)'),
cust_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
prod_retail_line_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for product retail lines.'),
retail_event_line_scenario_id INTEGER NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event line.'),
local_prod_nr STRING(100)
OPTIONS(description='The number which identifies the product in the operational retail management system within the given market / internal organization (i.e. the local item_2 number).  Note that the product number is unique for a certain point in time, but may be re_2-used later on. One product may be identified by several numbers in case of parallel listings or rolling listings. This is the number which has been configured in the cash registers of the given stores for the point in time when the retail transaction was made.'),
prod_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sales_2 variant of a product.'),
prod_variant_input_nr STRING(100)
OPTIONS(description='The number which identifies the product variant - as it has been scanned or manually keyed this. This can be an EAN_2, GTIN or a price lookup number (PLU)'),
prod_variant_input_nr_type_cd STRING(20)
OPTIONS(description='The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN_2, a GTIN or a product lookup number (PLU).'),
displayed_prod_variant_name STRING(100) NOT NULL
OPTIONS(description='The name of the product variant, as it is printed on the receipt.'),
weight_based_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product variant was sold (or returned) by weight instead of count.'),
prod_variant_cnt INTEGER
OPTIONS(description='The number of this product variant which has been sold or returned. (This attribute is empty for weight-based products.)'),
prod_variant_qty NUMERIC(29,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the product which was sold or returned.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_2 of measure.'),
unit_price NUMERIC(29,5) NOT NULL
OPTIONS(description='The price of a single unit_2 of the product variant, in the currency indicated by the currency code.'),
base_gross_val NUMERIC(29,5) NOT NULL
OPTIONS(description='The base gross amount of the sales_2 or return, i.e. quantity / count * unit_2 price. Discounts or price modifications are not considered.'),
retail_line_gross_val NUMERIC(29,5) NOT NULL
OPTIONS(description='The gross amount of the sales_2 or return, i.e. quantity / count * unit_2 price. Discounts and price changes are considered.'),
retail_line_net_val NUMERIC(29,5) NOT NULL
OPTIONS(description='The net amount of the sales_2 or return, i.e. quantity / count * unit_2 price. Discounts and price changes are considered. (This is a calculated amount!)'),
retail_line_vat_val NUMERIC(29,5) NOT NULL
OPTIONS(description='The total amount of value added tax which was charged for this line.'),
tax_class_cd STRING(20) NOT NULL OPTIONS(description='The code for the tax class, e.g. Reduced VAT Rate.'),
geo_area_key_type_cd STRING(20),
tax_pct NUMERIC(29,5) NOT NULL
OPTIONS(description='The actual tax percentage which is valid for the given tax class. E.g. 19%'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
turnover_relevant_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event line is to be considered as relevant for the turnover calculation. The flag is set to false, if the related retail event is not relevant for turnover or if the line has been cancelled.'),
discount_fg BOOL
OPTIONS(description='An indicator showing, if a discount or a price modification was applied to the product.'),
prod_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the product was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
price_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the unit_2 price was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
prod_return_reason_key_type_cd STRING(20),
return_txt STRING(1000) OPTIONS(description='A free text field describing the circumstances of the return.'),
orig_sales_event_key_type_cd STRING(20),
parent_line_seq INTEGER OPTIONS(description='In case the line represents a deposit, this is the related base line.'),
cancel_line_seq INTEGER
OPTIONS(description='In case the product retail line is cancelled, this is the number of the related cancellation line.'),
orig_item_nr INTEGER,
context_country STRING(20),
lidlplus_customer_cd STRING(100),
orig_receipt_nr INTEGER,
orig_store_nr INTEGER,
original_dat_formdate DATE,
original_orig_store_nr STRING(100),
original_orig_receipt_nr STRING(100),
original_pos_terminal_id STRING(100),
receipt_business_date DATE,
return_reason_cd STRING(2),
pos_terminal_id INTEGER,
source_system STRING(20),
extraction_dt DATE,
dwh_mapping_tmsp TIMESTAMP,
tf_error_fg INTEGER,
deleted_fg INTEGER,
record_id STRING(300),
filename STRING(1000) NOT NULL,
dwh_node_cd STRING(20) NOT NULL,
dwh_load_id INTEGER NOT NULL,
error_descr STRING(1000)
);