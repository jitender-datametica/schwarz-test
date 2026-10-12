/* --------------------------------------------------------------------------------
   DDL for table: t_cash_register_event_classification
   generated from Powerdesigner on Mittwoch, 19. Februar 2025 11:32:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_app_fraud_detection.t_cash_register_event_classification (
cash_register_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.'),
cash_register_event_nr STRING(20) NOT NULL
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re-cycled after some time.'),
scenario_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier of fraud detection scenario'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.)'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related cash register event happened.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
event_end_hr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Holds the hour from "Event end tmsp", so for example if the receipt close at "13:34:56", the value in the column will be "13".'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
cust_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the customer.If not customer exist then -1 is the default value.'),
cust_ident_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
cash_register_event_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='This column shows how much cash register events are relevant (default value is 1)'),
cash_register_event_affected_line_cnt BIGNUMERIC(38,0)
OPTIONS(description='Count of the cash register event lines for a particular scenario '),
cash_register_event_affected_gross_val BIGNUMERIC(38,5)
OPTIONS(description='Sum(gross) of the cash register event lines for a particular scenario '),
cash_register_event_affected_net_val BIGNUMERIC(38,5)
OPTIONS(description='Sum of the cash register event lines for a particular scenario '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cash_register_event_sid, scenario_id) NOT ENFORCED
) CLUSTER BY bus_dt
OPTIONS(description='This table lists link cash register event to all fraud scenarious which applies to this event');