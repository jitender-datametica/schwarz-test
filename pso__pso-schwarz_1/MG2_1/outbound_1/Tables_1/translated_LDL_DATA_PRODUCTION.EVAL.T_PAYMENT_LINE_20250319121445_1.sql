DROP TABLE IF EXISTS ldl_data_production_eval.t_payment_line_20250319121445_1;
CREATE OR REPLACE TABLE ldl_data_production_eval.t_payment_line_20250319121445_1 (
retail_event_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_1 or return of products..'),
retail_event_line_seq INTEGER NOT NULL OPTIONS(description='The number of the line in the retail event.'),
paym_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the payment process started.'),
paym_end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the payment process was finished.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
store_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country_1 is not identical to a political country.)'),
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
cash_register_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_hash STRING(32) NOT NULL
OPTIONS(description='The encrypted number of the cashier. (The hash is unique for a given store and a day.)'),
cust_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
retail_event_line_scenario_id INTEGER NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event line.'),
paym_line_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for payment lines. It distinguishes between incoming and outgoing payments, i.e. payments made by the customer and payments made to the customer.'),
local_paym_val NUMERIC(29,5)
OPTIONS(description='The amount which was paid in local currency. If the amount was paid by the customer, the sign is positive. If the amount was paid to the customer, the sign is negative. If the payment was in a foreign currency, this is the local currency equivalent.'),
local_curr_cd STRING(3)
OPTIONS(description='The code identifying the local currency of the store, according to ISO 4217.'),
foreign_paym_val NUMERIC(29,5)
OPTIONS(description='The amount which was paid in foreign currency. (indicated by the foreign currency code) If the amount was paid by the customer, the sign is positive. If the amount was paid to the customer, the sign is negative. '),
foreign_curr_cd STRING(3) OPTIONS(description='The code identifying the foreign currency, according to ISO 4217.'),
round_diff INTEGER
OPTIONS(description='The difference between the sum of the retail event lines and the payment amount. The amounts can be different, if prices are on a lower granularity than the smallest coin used, or if the payment is made in a foreign currency.The amount is shown in local currency.'),
paym_type_id INTEGER NOT NULL
OPTIONS(description='The identifier for the way of payment, i.e. cash, card, voucher, etc.'),
card_txn_nr STRING(20) OPTIONS(description='The transaction number for the card payment.'),
paym_card_type_cd STRING(20)
OPTIONS(description='The code identifying the type of card which is used for payment, e.g. Maestro, Visa, Mastercard, etc.'),
card_txn_type_cd STRING(20)
OPTIONS(description='The code identifying the kind of card transaction. E.g. debit, credit, cancellation, etc.'),
card_auth_method_cd STRING(20) OPTIONS(description='The code identifying the authorization method for a card payment.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid, retail_event_line_seq) NOT ENFORCED
) CLUSTER BY country_org_cd, bus_dt
OPTIONS(description='A payment is the transfer of money from one party to another party. This includes on the one hand payments from a customer to the cashier in exchange for the products the customer bought, and on the other hand payments from the cashier to a customer. The second case can happen, if change is given to the customer or if the customer has returned products or deposit items.');