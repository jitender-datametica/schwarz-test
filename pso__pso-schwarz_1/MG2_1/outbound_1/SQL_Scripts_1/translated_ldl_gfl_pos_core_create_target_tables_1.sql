CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_txj_510_load_2_tcache_daily_vat_statistics_intermediate_1 (
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store, in which the end-of-day processing happens.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
stat_dt DATE NOT NULL OPTIONS(description='The date when the VAT statistics were collected. '),
bus_dt DATE NOT NULL OPTIONS(description='The business date for which the VAT statistics are generated.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
curr_stat_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the current record for the given key, i.e. the record with the latest statistics date. Filtering on this flag returns the statistics after any corrections.'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the geographical area to which the tax class applies.'),
tax_class_cd STRING(20) NOT NULL OPTIONS(description='The code for the tax class, e.g. Reduced VAT Rate.'),
vat_stat_calc_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the VAT statistics have been calculated.'),
turnover_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The gross turnover in the currency indicated by the currency code, for this store and time period which is taxed with the given VAT class.'),
vat_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The resulting VAT amout in the currency indicated by the currency code, for the given store, time period and VAT class.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (store_sid, bus_dt, stat_dt, geo_area_sid, tax_class_cd, vat_stat_calc_method_cd) NOT ENFORCED
);


CREATE OR REPLACE TABLE ldl_data_production_etl.t_txj_510_load_2_tcache_txj_510_load_1 (
load_id BIGNUMERIC(38,0) NOT NULL,
wh_id BIGNUMERIC(38,0) NOT NULL,
extraction_date DATE NOT NULL,
record_cd STRING(12) COLLATE 'und:ci' NOT NULL,
period_cd STRING(1) COLLATE 'und:ci',
closure_cd STRING(1) COLLATE 'und:ci',
orig_store_nr INTEGER NOT NULL,
bic_zmlila STRING(20) COLLATE 'und:ci',
vat_group_a_turnover_gross_val NUMERIC(18,5),
vat_group_a_vat_val NUMERIC(18,5),
vat_group_b_turnover_gross_val NUMERIC(18,5),
vat_group_b_vat_val NUMERIC(18,5),
vat_group_c_turnover_gross_val NUMERIC(18,5),
vat_group_c_vat_val NUMERIC(18,5),
vat_group_d_turnover_gross_val NUMERIC(18,5),
vat_group_d_vat_val NUMERIC(18,5),
vat_group_e_turnover_gross_val NUMERIC(18,5),
vat_group_e_vat_val NUMERIC(18,5),
vat_group_f_turnover_gross_val NUMERIC(18,5),
vat_group_f_vat_val NUMERIC(18,5),
vat_group_g_turnover_gross_val NUMERIC(18,5),
vat_group_g_vat_val NUMERIC(18,5),
vat_group_h_turnover_gross_val NUMERIC(18,5),
vat_group_h_vat_val NUMERIC(18,5),
vat_group_i_turnover_gross_val NUMERIC(18,5),
vat_group_i_vat_val NUMERIC(18,5),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);


DROP TABLE IF EXISTS ldl_data_production_etl.t_tcache_pos_receipt_load_2_tcache_retail_event_intermediate_1;
CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_pos_receipt_load_2_tcache_retail_event_intermediate_1 (
retail_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the retail event, i.e. for the sales_1 or return of products..'),
cash_register_event_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_1-cycled after some time.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the retail event started.'),
event_end_tmsp TIMESTAMP NOT NULL OPTIONS(description='The end timestamp of the retail event.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the retail event happend.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
cash_register_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
cust_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
cust_ident_type_cd STRING(20)
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
retail_event_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for retail events.'),
retail_event_scenario_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event.'),
offline_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered while the cash register was offline.'),
cancel_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the transaction was cancelled.'),
suspend_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was suspended. Some later transaction may resume the suspended transaction to complete it.'),
cont_retail_event_sid BIGNUMERIC(38,0)
OPTIONS(description='In case the cash register transaction was suspended, this is the transaction which continued it.'),
training_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered in training mode, e.g. when a (new) cashier learns how to use the functionalities of the cash register.'),
txn_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total gross amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_net_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total net amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_vat_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total VAT amount of the retail transaction. (amount in the currency defined by the currency code)'),
turnover_relevant_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event is to be considered as relevant for the turnover calculation.'),
service_tm_sec_meas BIGNUMERIC(38,5)
OPTIONS(description='The time in seconds needed for entering all lines of the transaction.'),
paym_tm_sec_meas BIGNUMERIC(38,5)
OPTIONS(description='The time in seconds needed for the payment (or return of money to the customer)'),
scanned_lines_cnt BIGNUMERIC(38,0) OPTIONS(description='The number of lines on this receipt which have been scanned.'),
keyed_lines_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of lines on this receipt which have been manually keyed in.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid) NOT ENFORCED
) CLUSTER BY bus_dt;


DROP TABLE IF EXISTS ldl_data_production_etl.t_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_1;
CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_pos_receipt_load_2_tcache_product_retail_line_intermediate_1 (
retail_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_1 or return of products..'),
retail_event_line_seq BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number of the line in the retail event.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the scanning (or the manual input) of the article started.'),
event_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the scanning (or the manual input) of the article was finished.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
retail_event_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the related retail event was finished.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL,
cash_register_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
cust_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
prod_retail_line_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for product retail lines.'),
retail_event_line_scenario_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event line.'),
prod_variant_sidx BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sales_1 variant of a product.'),
prod_variant_input_nr STRING(100)
OPTIONS(description='The number which identifies the product variant - as it has been scanned or manually keyed this. This can be an EAN_1, GTIN or a price lookup number (PLU)'),
prod_variant_input_nr_type_cd STRING(20)
OPTIONS(description='The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN_1, a GTIN or a product lookup number (PLU).'),
displayed_prod_variant_name STRING(100) NOT NULL
OPTIONS(description='The name of the product variant, as it is printed on the receipt.'),
weight_based_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product variant was sold (or returned) by weight instead of count.'),
prod_variant_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of this product variant which has been sold or returned. (This attribute is empty for weight-based products.)'),
prod_variant_qty NUMERIC(18,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the product which was sold or returned.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_1 of measure.'),
unit_price BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The price of a single unit_1 of the product variant, in the currency indicated by the currency code.'),
base_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The base gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts or price modifications are not considered.'),
retail_line_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered.'),
retail_line_net_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The net amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered. (This is a calculated amount!)'),
retail_line_vat_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total amount of value added tax which was charged for this line.'),
tax_class_cd STRING(20) NOT NULL OPTIONS(description='The code for the tax class, e.g. Reduced VAT Rate.'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the geographical area to which the tax class applies.'),
tax_pct BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The actual tax percentage which is valid for the given tax class. E.g. 19%'),
turnover_relevant_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event line is to be considered as relevant for the turnover calculation. The flag is set to false, if the related retail event is not relevant for turnover or if the line has been cancelled.'),
prod_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the product was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
price_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the unit_1 price was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
prod_return_reason_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the reasons why a product was returend to the store.'),
return_txt STRING(1000) OPTIONS(description='A free text field describing the circumstances of the return.'),
orig_sales_event_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the sales_1 transaction in which the returned product was sold.'),
parent_line_seq BIGNUMERIC(38,0)
OPTIONS(description='In case the line represents a deposit, this is the related base line.'),
cancel_line_seq BIGNUMERIC(38,0)
OPTIONS(description='In case the product retail line is cancelled, this is the number of the related cancellation line.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid, retail_event_line_seq) NOT ENFORCED
) CLUSTER BY bus_dt;


CREATE OR REPLACE TABLE defaultschema.t_tcache_pos_receipt_load_gfl_2_tcache_pos_receipt_load_1 (
record_id BIGNUMERIC(38,0),
source_system STRING(20) COLLATE 'und:ci',
extraction_date DATE,
extraction_ts TIMESTAMP,
bic_zmlila STRING(20),
load_id BIGNUMERIC(38,0) NOT NULL,
receipt_transactiontype_id STRING(3) COLLATE 'und:ci',
context_load_id BIGNUMERIC(38,0),
context_country STRING(20),
orig_wh_nr BIGNUMERIC(38,0),
orig_store_nr BIGNUMERIC(38,0),
pos_terminal_id BIGNUMERIC(38,0),
orig_receipt_nr BIGNUMERIC(38,0),
val_retail NUMERIC(18,4),
orig_cnt_scanpos BIGNUMERIC(38,0),
orig_cnt_dirpos BIGNUMERIC(38,0),
dur_receipt BIGNUMERIC(38,0),
resumed_trans_store_nr BIGNUMERIC(38,0),
resumed_trans_terminal_id BIGNUMERIC(38,0),
resumed_trans_date DATE,
resumed_trans_receipt_nr BIGNUMERIC(38,0),
receipt_business_date DATE,
offline_fg BOOL,
training_fg BOOL,
dur_service_time BIGNUMERIC(38,0),
dur_pay_change_time BIGNUMERIC(38,0),
val_retail_net NUMERIC(18,4),
receiptline_timestamp_begin STRING(30),
receiptline_timestamp_end STRING(30),
receipt_timestamp_begin STRING(30),
receipt_timestamp_end STRING(30),
item_desc STRING(40) COLLATE 'und:ci',
lidlplus_customer_cd STRING(100) COLLATE 'und:ci',
lidlplus_ident_type_cd STRING(20) COLLATE 'und:ci',
posnr BIGNUMERIC(38,0),
item_entry_method_cd STRING(2) COLLATE 'und:ci',
barcode STRING(50),
price_retail NUMERIC(18,4),
qty_sold NUMERIC(16,3),
fg_weight STRING(1) COLLATE 'und:ci',
price_sum_retail NUMERIC(16,2),
val_discount NUMERIC(18,4),
receiptline_transactiontype_id STRING(3) COLLATE 'und:ci',
val_vat NUMERIC(18,4),
price_entry_method_cd STRING(2) COLLATE 'und:ci',
parent_line_nr BIGNUMERIC(38,0),
pct_vat NUMERIC(9,4),
return_reason_cd STRING(2) COLLATE 'und:ci',
return_text STRING(40) COLLATE 'und:ci',
voided_by_line_nr BIGNUMERIC(38,0),
val_retail_orig NUMERIC(18,4),
type_vat STRING(3) COLLATE 'und:ci',
original_orig_receipt_nr STRING(100) COLLATE 'und:ci',
original_pos_terminal_id STRING(100) COLLATE 'und:ci',
original_orig_store_nr STRING(100) COLLATE 'und:ci',
original_dat_formdate DATE,
dwh_load_id BIGNUMERIC(38,0),
extraction_dt DATE,
dwh_mapping_dt DATE
);


DROP TABLE IF EXISTS ldl_data_production_etl.t_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_1;
CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos01_1
(
retail_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_1 or return of products..'),
retail_event_line_seq BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number of the line in the retail event.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the scanning (or the manual input) of the article started.'),
event_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the scanning (or the manual input) of the article was finished.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
retail_event_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the related retail event was finished.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL,
cash_register_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
cust_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
prod_retail_line_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for product retail lines.'),
retail_event_line_scenario_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event line.'),
prod_variant_sidx BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sales_1 variant of a product.'),
prod_variant_input_nr STRING(100)
OPTIONS(description='The number which identifies the product variant - as it has been scanned or manually keyed this. This can be an EAN_1, GTIN or a price lookup number (PLU)'),
prod_variant_input_nr_type_cd STRING(20)
OPTIONS(description='The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN_1, a GTIN or a product lookup number (PLU).'),
displayed_prod_variant_name STRING(100) NOT NULL
OPTIONS(description='The name of the product variant, as it is printed on the receipt.'),
weight_based_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product variant was sold (or returned) by weight instead of count.'),
prod_variant_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of this product variant which has been sold or returned. (This attribute is empty for weight-based products.)'),
prod_variant_qty NUMERIC(18,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the product which was sold or returned.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_1 of measure.'),
unit_price BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The price of a single unit_1 of the product variant, in the currency indicated by the currency code.'),
base_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The base gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts or price modifications are not considered.'),
retail_line_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered.'),
retail_line_net_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The net amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered. (This is a calculated amount!)'),
retail_line_vat_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total amount of value added tax which was charged for this line.'),
tax_class_cd STRING(20) NOT NULL OPTIONS(description='The code for the tax class, e.g. Reduced VAT Rate.'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the geographical area to which the tax class applies.'),
tax_pct BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The actual tax percentage which is valid for the given tax class. E.g. 19%'),
turnover_relevant_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event line is to be considered as relevant for the turnover calculation. The flag is set to false, if the related retail event is not relevant for turnover or if the line has been cancelled.'),
prod_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the product was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
price_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the unit_1 price was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
prod_return_reason_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the reasons why a product was returend to the store.'),
return_txt STRING(1000) OPTIONS(description='A free text field describing the circumstances of the return.'),
orig_sales_event_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the sales_1 transaction in which the returned product was sold.'),
parent_line_seq BIGNUMERIC(38,0)
OPTIONS(description='In case the line represents a deposit, this is the related base line.'),
cancel_line_seq BIGNUMERIC(38,0)
OPTIONS(description='In case the product retail line is cancelled, this is the number of the related cancellation line.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid, retail_event_line_seq) NOT ENFORCED
) CLUSTER BY bus_dt;


DROP TABLE IF EXISTS ldl_data_production_etl.t_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_1;
CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos08_1
(
retail_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_1 or return of products..'),
retail_event_line_seq BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number of the line in the retail event.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the scanning (or the manual input) of the article started.'),
event_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the scanning (or the manual input) of the article was finished.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
retail_event_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the related retail event was finished.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL,
cash_register_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
cust_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
prod_retail_line_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for product retail lines.'),
retail_event_line_scenario_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event line.'),
prod_variant_sidx BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sales_1 variant of a product.'),
prod_variant_input_nr STRING(100)
OPTIONS(description='The number which identifies the product variant - as it has been scanned or manually keyed this. This can be an EAN_1, GTIN or a price lookup number (PLU)'),
prod_variant_input_nr_type_cd STRING(20)
OPTIONS(description='The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN_1, a GTIN or a product lookup number (PLU).'),
displayed_prod_variant_name STRING(100) NOT NULL
OPTIONS(description='The name of the product variant, as it is printed on the receipt.'),
weight_based_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product variant was sold (or returned) by weight instead of count.'),
prod_variant_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of this product variant which has been sold or returned. (This attribute is empty for weight-based products.)'),
prod_variant_qty NUMERIC(18,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the product which was sold or returned.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_1 of measure.'),
unit_price BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The price of a single unit_1 of the product variant, in the currency indicated by the currency code.'),
base_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The base gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts or price modifications are not considered.'),
retail_line_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered.'),
retail_line_net_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The net amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered. (This is a calculated amount!)'),
retail_line_vat_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total amount of value added tax which was charged for this line.'),
tax_class_cd STRING(20) NOT NULL OPTIONS(description='The code for the tax class, e.g. Reduced VAT Rate.'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the geographical area to which the tax class applies.'),
tax_pct BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The actual tax percentage which is valid for the given tax class. E.g. 19%'),
turnover_relevant_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event line is to be considered as relevant for the turnover calculation. The flag is set to false, if the related retail event is not relevant for turnover or if the line has been cancelled.'),
prod_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the product was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
price_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the unit_1 price was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
prod_return_reason_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the reasons why a product was returend to the store.'),
return_txt STRING(1000) OPTIONS(description='A free text field describing the circumstances of the return.'),
orig_sales_event_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the sales_1 transaction in which the returned product was sold.'),
parent_line_seq BIGNUMERIC(38,0)
OPTIONS(description='In case the line represents a deposit, this is the related base line.'),
cancel_line_seq BIGNUMERIC(38,0)
OPTIONS(description='In case the product retail line is cancelled, this is the number of the related cancellation line.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid, retail_event_line_seq) NOT ENFORCED
) CLUSTER BY bus_dt;


DROP TABLE IF EXISTS ldl_data_production_etl.t_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_1;
CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos09_1
(
retail_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_1 or return of products..'),
retail_event_line_seq BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number of the line in the retail event.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the scanning (or the manual input) of the article started.'),
event_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the scanning (or the manual input) of the article was finished.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
retail_event_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the related retail event was finished.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL,
cash_register_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
cust_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
prod_retail_line_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for product retail lines.'),
retail_event_line_scenario_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event line.'),
prod_variant_sidx BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sales_1 variant of a product.'),
prod_variant_input_nr STRING(100)
OPTIONS(description='The number which identifies the product variant - as it has been scanned or manually keyed this. This can be an EAN_1, GTIN or a price lookup number (PLU)'),
prod_variant_input_nr_type_cd STRING(20)
OPTIONS(description='The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN_1, a GTIN or a product lookup number (PLU).'),
displayed_prod_variant_name STRING(100) NOT NULL
OPTIONS(description='The name of the product variant, as it is printed on the receipt.'),
weight_based_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product variant was sold (or returned) by weight instead of count.'),
prod_variant_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of this product variant which has been sold or returned. (This attribute is empty for weight-based products.)'),
prod_variant_qty NUMERIC(18,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the product which was sold or returned.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_1 of measure.'),
unit_price BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The price of a single unit_1 of the product variant, in the currency indicated by the currency code.'),
base_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The base gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts or price modifications are not considered.'),
retail_line_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered.'),
retail_line_net_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The net amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered. (This is a calculated amount!)'),
retail_line_vat_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total amount of value added tax which was charged for this line.'),
tax_class_cd STRING(20) NOT NULL OPTIONS(description='The code for the tax class, e.g. Reduced VAT Rate.'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the geographical area to which the tax class applies.'),
tax_pct BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The actual tax percentage which is valid for the given tax class. E.g. 19%'),
turnover_relevant_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event line is to be considered as relevant for the turnover calculation. The flag is set to false, if the related retail event is not relevant for turnover or if the line has been cancelled.'),
prod_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the product was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
price_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the unit_1 price was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
prod_return_reason_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the reasons why a product was returend to the store.'),
return_txt STRING(1000) OPTIONS(description='A free text field describing the circumstances of the return.'),
orig_sales_event_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the sales_1 transaction in which the returned product was sold.'),
parent_line_seq BIGNUMERIC(38,0)
OPTIONS(description='In case the line represents a deposit, this is the related base line.'),
cancel_line_seq BIGNUMERIC(38,0)
OPTIONS(description='In case the product retail line is cancelled, this is the number of the related cancellation line.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid, retail_event_line_seq) NOT ENFORCED
) CLUSTER BY bus_dt;


DROP TABLE IF EXISTS ldl_data_production_etl.t_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_1;
CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_pos_receiptline_load_2_tcache_product_retail_line_intermediate_pos10_1
(
retail_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_1 or return of products..'),
retail_event_line_seq BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number of the line in the retail event.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the scanning (or the manual input) of the article started.'),
event_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the scanning (or the manual input) of the article was finished.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
retail_event_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the related retail event was finished.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL,
cash_register_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
cust_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
prod_retail_line_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for product retail lines.'),
retail_event_line_scenario_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event line.'),
prod_variant_sidx BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sales_1 variant of a product.'),
prod_variant_input_nr STRING(100)
OPTIONS(description='The number which identifies the product variant - as it has been scanned or manually keyed this. This can be an EAN_1, GTIN or a price lookup number (PLU)'),
prod_variant_input_nr_type_cd STRING(20)
OPTIONS(description='The code identifying the kind of the number which has been scanned or typed in, in order to identify the product variant. The product variant number can be identified by an EAN_1, a GTIN or a product lookup number (PLU).'),
displayed_prod_variant_name STRING(100) NOT NULL
OPTIONS(description='The name of the product variant, as it is printed on the receipt.'),
weight_based_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product variant was sold (or returned) by weight instead of count.'),
prod_variant_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of this product variant which has been sold or returned. (This attribute is empty for weight-based products.)'),
prod_variant_qty NUMERIC(18,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the product which was sold or returned.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_1 of measure.'),
unit_price BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The price of a single unit_1 of the product variant, in the currency indicated by the currency code.'),
base_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The base gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts or price modifications are not considered.'),
retail_line_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The gross amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered.'),
retail_line_net_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The net amount of the sales_1 or return, i.e. quantity / count * unit_1 price. Discounts and price changes are considered. (This is a calculated amount!)'),
retail_line_vat_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total amount of value added tax which was charged for this line.'),
tax_class_cd STRING(20) NOT NULL OPTIONS(description='The code for the tax class, e.g. Reduced VAT Rate.'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the geographical area to which the tax class applies.'),
tax_pct BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The actual tax percentage which is valid for the given tax class. E.g. 19%'),
turnover_relevant_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event line is to be considered as relevant for the turnover calculation. The flag is set to false, if the related retail event is not relevant for turnover or if the line has been cancelled.'),
prod_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the product was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
price_entry_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how the unit_1 price was entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.'),
prod_return_reason_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the reasons why a product was returend to the store.'),
return_txt STRING(1000) OPTIONS(description='A free text field describing the circumstances of the return.'),
orig_sales_event_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the sales_1 transaction in which the returned product was sold.'),
parent_line_seq BIGNUMERIC(38,0)
OPTIONS(description='In case the line represents a deposit, this is the related base line.'),
cancel_line_seq BIGNUMERIC(38,0)
OPTIONS(description='In case the product retail line is cancelled, this is the number of the related cancellation line.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid, retail_event_line_seq) NOT ENFORCED
) CLUSTER BY bus_dt;


DROP TABLE IF EXISTS ldl_data_production_etl.t_tcache_pos_receiptheader_load_2_tcache_retail_event_imdt_pos01_1;
CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_pos_receiptheader_load_2_tcache_retail_event_imdt_pos01_1 (
retail_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the retail event, i.e. for the sales_1 or return of products..'),
cash_register_event_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_1-cycled after some time.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the retail event started.'),
event_end_tmsp TIMESTAMP NOT NULL OPTIONS(description='The end timestamp of the retail event.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the retail event happend.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
cash_register_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
cust_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
cust_ident_type_cd STRING(20)
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
retail_event_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for retail events.'),
retail_event_scenario_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event.'),
offline_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered while the cash register was offline.'),
cancel_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the transaction was cancelled.'),
suspend_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was suspended. Some later transaction may resume the suspended transaction to complete it.'),
cont_retail_event_sid BIGNUMERIC(38,0)
OPTIONS(description='In case the cash register transaction was suspended, this is the transaction which continued it.'),
training_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered in training mode, e.g. when a (new) cashier learns how to use the functionalities of the cash register.'),
txn_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total gross amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_net_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total net amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_vat_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total VAT amount of the retail transaction. (amount in the currency defined by the currency code)'),
turnover_relevant_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event is to be considered as relevant for the turnover calculation.'),
service_tm_sec_meas BIGNUMERIC(38,5)
OPTIONS(description='The time in seconds needed for entering all lines of the transaction.'),
paym_tm_sec_meas BIGNUMERIC(38,5)
OPTIONS(description='The time in seconds needed for the payment (or return of money to the customer)'),
scanned_lines_cnt BIGNUMERIC(38,0) OPTIONS(description='The number of lines on this receipt which have been scanned.'),
keyed_lines_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of lines on this receipt which have been manually keyed in.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid) NOT ENFORCED
) CLUSTER BY bus_dt;


DROP TABLE IF EXISTS ldl_data_production_etl.t_tcache_pos_receiptheader_load_2_tcache_retail_event_imdt_pos08_1;
CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_pos_receiptheader_load_2_tcache_retail_event_imdt_pos08_1 (
retail_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the retail event, i.e. for the sales_1 or return of products..'),
cash_register_event_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_1-cycled after some time.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the retail event started.'),
event_end_tmsp TIMESTAMP NOT NULL OPTIONS(description='The end timestamp of the retail event.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the retail event happend.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
cash_register_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
cust_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
cust_ident_type_cd STRING(20)
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
retail_event_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for retail events.'),
retail_event_scenario_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event.'),
offline_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered while the cash register was offline.'),
cancel_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the transaction was cancelled.'),
suspend_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was suspended. Some later transaction may resume the suspended transaction to complete it.'),
cont_retail_event_sid BIGNUMERIC(38,0)
OPTIONS(description='In case the cash register transaction was suspended, this is the transaction which continued it.'),
training_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered in training mode, e.g. when a (new) cashier learns how to use the functionalities of the cash register.'),
txn_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total gross amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_net_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total net amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_vat_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total VAT amount of the retail transaction. (amount in the currency defined by the currency code)'),
turnover_relevant_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event is to be considered as relevant for the turnover calculation.'),
service_tm_sec_meas BIGNUMERIC(38,5)
OPTIONS(description='The time in seconds needed for entering all lines of the transaction.'),
paym_tm_sec_meas BIGNUMERIC(38,5)
OPTIONS(description='The time in seconds needed for the payment (or return of money to the customer)'),
scanned_lines_cnt BIGNUMERIC(38,0) OPTIONS(description='The number of lines on this receipt which have been scanned.'),
keyed_lines_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of lines on this receipt which have been manually keyed in.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid) NOT ENFORCED
) CLUSTER BY bus_dt;


DROP TABLE IF EXISTS ldl_data_production_etl.t_tcache_pos_receiptheader_load_2_tcache_retail_event_imdt_pos09_1;
CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_pos_receiptheader_load_2_tcache_retail_event_imdt_pos09_1 (
retail_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the retail event, i.e. for the sales_1 or return of products..'),
cash_register_event_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_1-cycled after some time.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the retail event started.'),
event_end_tmsp TIMESTAMP NOT NULL OPTIONS(description='The end timestamp of the retail event.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the retail event happend.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
cash_register_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
cust_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
cust_ident_type_cd STRING(20)
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
retail_event_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for retail events.'),
retail_event_scenario_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event.'),
offline_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered while the cash register was offline.'),
cancel_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the transaction was cancelled.'),
suspend_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was suspended. Some later transaction may resume the suspended transaction to complete it.'),
cont_retail_event_sid BIGNUMERIC(38,0)
OPTIONS(description='In case the cash register transaction was suspended, this is the transaction which continued it.'),
training_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered in training mode, e.g. when a (new) cashier learns how to use the functionalities of the cash register.'),
txn_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total gross amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_net_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total net amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_vat_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total VAT amount of the retail transaction. (amount in the currency defined by the currency code)'),
turnover_relevant_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event is to be considered as relevant for the turnover calculation.'),
service_tm_sec_meas BIGNUMERIC(38,5)
OPTIONS(description='The time in seconds needed for entering all lines of the transaction.'),
paym_tm_sec_meas BIGNUMERIC(38,5)
OPTIONS(description='The time in seconds needed for the payment (or return of money to the customer)'),
scanned_lines_cnt BIGNUMERIC(38,0) OPTIONS(description='The number of lines on this receipt which have been scanned.'),
keyed_lines_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of lines on this receipt which have been manually keyed in.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid) NOT ENFORCED
) CLUSTER BY bus_dt;


DROP TABLE IF EXISTS ldl_data_production_etl.t_tcache_pos_receiptheader_load_2_tcache_retail_event_imdt_pos10_1;
CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_pos_receiptheader_load_2_tcache_retail_event_imdt_pos10_1 (
retail_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the retail event, i.e. for the sales_1 or return of products..'),
cash_register_event_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_1-cycled after some time.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the retail event started.'),
event_end_tmsp TIMESTAMP NOT NULL OPTIONS(description='The end timestamp of the retail event.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the retail event happend.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
cash_register_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee_1, who has authorized the transaction. (This is not an employee_1 number!)'),
cust_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
cust_ident_type_cd STRING(20)
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
retail_event_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for retail events.'),
retail_event_scenario_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event.'),
offline_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered while the cash register was offline.'),
cancel_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the transaction was cancelled.'),
suspend_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was suspended. Some later transaction may resume the suspended transaction to complete it.'),
cont_retail_event_sid BIGNUMERIC(38,0)
OPTIONS(description='In case the cash register transaction was suspended, this is the transaction which continued it.'),
training_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered in training mode, e.g. when a (new) cashier learns how to use the functionalities of the cash register.'),
txn_gross_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total gross amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_net_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total net amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_vat_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The total VAT amount of the retail transaction. (amount in the currency defined by the currency code)'),
turnover_relevant_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event is to be considered as relevant for the turnover calculation.'),
service_tm_sec_meas BIGNUMERIC(38,5)
OPTIONS(description='The time in seconds needed for entering all lines of the transaction.'),
paym_tm_sec_meas BIGNUMERIC(38,5)
OPTIONS(description='The time in seconds needed for the payment (or return of money to the customer)'),
scanned_lines_cnt BIGNUMERIC(38,0) OPTIONS(description='The number of lines on this receipt which have been scanned.'),
keyed_lines_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of lines on this receipt which have been manually keyed in.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid) NOT ENFORCED
) CLUSTER BY bus_dt;