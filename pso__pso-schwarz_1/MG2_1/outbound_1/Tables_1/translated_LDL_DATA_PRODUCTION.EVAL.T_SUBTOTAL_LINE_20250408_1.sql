DROP TABLE IF EXISTS ldl_data_production_eval.t_subtotal_line_20250408_1;
CREATE OR REPLACE TABLE ldl_data_production_eval.t_subtotal_line_20250408_1 (
retail_event_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_1 or return of products..'),
retail_event_line_seq INTEGER NOT NULL OPTIONS(description='The number of the line in the retail event.'),
event_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the subtotal was calculated.'),
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
OPTIONS(description='An event displaying the current amount of a retail event in progress.');