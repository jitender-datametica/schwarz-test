CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_pos_receiptheader_load_2_tcache_retail_event_imdt_pos09 (
retail_event_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the retail event, i.e. for the sales or return of products..'),
cash_register_event_nr INTEGER NOT NULL
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re-cycled after some time.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the retail event started.'),
event_end_tmsp TIMESTAMP NOT NULL OPTIONS(description='The end timestamp of the retail event.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
store_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the retail event happend.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country organization.'),
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country organization.'),
cash_register_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
auth_by_nr STRING(20)
OPTIONS(description='In case of a cancellation or any other non-standard operaion, the transaction must be authorized by the store manager or by another employee. This is the number which identifies the employee, who has authorized the transaction. (This is not an employee number!)'),
cust_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
cust_ident_type_cd STRING(20)
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
retail_event_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for retail events.'),
retail_event_scenario_id INTEGER NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event.'),
offline_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered while the cash register was offline.'),
cancel_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the transaction was cancelled.'),
suspend_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was suspended. Some later transaction may resume the suspended transaction to complete it.'),
cont_retail_event_sid INTEGER
OPTIONS(description='In case the cash register transaction was suspended, this is the transaction which continued it.'),
training_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered in training mode, e.g. when a (new) cashier learns how to use the functionalities of the cash register.'),
txn_gross_val NUMERIC(29,5) NOT NULL
OPTIONS(description='The total gross amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_net_val NUMERIC(29,5) NOT NULL
OPTIONS(description='The total net amount of the retail transaction. (amount in the currency defined by the currency code)'),
txn_vat_val NUMERIC(29,5) NOT NULL
OPTIONS(description='The total VAT amount of the retail transaction. (amount in the currency defined by the currency code)'),
turnover_relevant_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event is to be considered as relevant for the turnover calculation.'),
service_tm_sec_meas NUMERIC(29,5)
OPTIONS(description='The time in seconds needed for entering all lines of the transaction.'),
paym_tm_sec_meas NUMERIC(29,5)
OPTIONS(description='The time in seconds needed for the payment (or return of money to the customer)'),
scanned_lines_cnt INTEGER OPTIONS(description='The number of lines on this receipt which have been scanned.'),
keyed_lines_cnt INTEGER OPTIONS(description='The number of lines on this receipt which have been manually keyed in.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid) NOT ENFORCED
);