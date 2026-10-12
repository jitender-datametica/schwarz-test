CREATE TABLE IF NOT EXISTS ldl_data_core_app_fraud_detection.t_cash_register_event_relationship (
cash_register_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.'),
cash_register_event_rel_type_cd STRING(20) NOT NULL
OPTIONS(description='The way one cash register event is related to another, return to sales receipt (Geldrügabe zu Originalbon) '),
rel_cash_register_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The child cash register event, which is part of the scenario like following receipt of show price or sale receipt of return'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country for which the related country organization is responsible, e.g. cash_register_event_sid. (The business country is not identical to a political country.)'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
rel_bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cash_register_event_sid, cash_register_event_rel_type_cd, rel_cash_register_event_sid) NOT ENFORCED
) CLUSTER BY country_org_cd
OPTIONS(description='The table lists the related cash register events of a main cash register event which is identified by a scenario e.g. return main scenario and its relevant sale receipt ');