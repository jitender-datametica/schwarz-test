DROP TABLE IF EXISTS ldl_data_production_core_rel.t_price_information_event;
CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_price_information_event (
price_info_event_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the price information event. (The surrogate key is unique across all types of cash register events.)'),
cash_register_event_nr INTEGER NOT NULL
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re-cycled after some time.'),
event_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the event happened. In case a duration is recorded for the event, this is the start timestamp.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the price information event is counted.'),
store_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the price information event happened.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country is not identical to a political country.)'),
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
offline_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered while the cash register was offline.'),
cancel_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the transaction was cancelled.'),
suspend_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was suspended. Some later transaction may resume the suspended transaction to complete it.'),
training_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the transaction was entered in training mode, e.g. when a (new) cashier learns how to use the functionalities of the cash register.'),
prod_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sales variant of a product.'),
wawi_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the Wawi item.'),
prod_price NUMERIC(29,5) NOT NULL OPTIONS(description='The price which has been displayed for the product.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
prod_bought_fg BOOL NOT NULL
OPTIONS(description='An indictor showing, if the product was bought after its price was looked up.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (price_info_event_sid) NOT ENFORCED
) CLUSTER BY bus_dt
OPTIONS(description='A price information event is a transaction where the cashier scans the barcode of an item in order to show its retail price. The item is not sold. The price lookup is for information only.');