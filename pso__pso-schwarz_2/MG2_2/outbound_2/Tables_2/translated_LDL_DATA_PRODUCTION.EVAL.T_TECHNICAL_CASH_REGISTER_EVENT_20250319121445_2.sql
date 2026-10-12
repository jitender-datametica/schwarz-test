DROP TABLE IF EXISTS ldl_data_production_eval.t_technical_cash_register_event_20250319121445_2;
CREATE OR REPLACE TABLE ldl_data_production_eval.t_technical_cash_register_event_20250319121445_2 (
tech_cash_register_event_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the technical cash register event. (The surrogate key is unique across all types of cash register events.)'),
cash_register_event_nr INTEGER NOT NULL
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_2-cycled after some time.'),
event_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the technical cash register event happened. '),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the technical cash register event is counted.'),
store_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the technical cash register event happend.'),
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
cashier_hash STRING(32) NOT NULL
OPTIONS(description='The encrypted number of the cashier. (The hash is unique for a given store and a day.)'),
tech_cash_register_event_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of technical cash register event.'),
offline_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered while the cash register was offline.'),
cancel_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the transaction was cancelled.'),
suspend_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was suspended. Some later transaction may resume the suspended transaction to complete it.'),
training_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered in training mode, e.g. when a (new) cashier learns how to use the functionalities of the cash register.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (tech_cash_register_event_sid) NOT ENFORCED
) CLUSTER BY bus_dt
OPTIONS(description='Technical cash register events include transactions such as log on / log off, locking or unlocking the cash register reprinting a receipt.');