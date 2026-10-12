CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_cash_register_event_classification_2 (cash_register_event_sid
OPTIONS(description='The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.'),
cash_register_event_nr
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_2-cycled after some time.'),
scenario_id OPTIONS(description='The unique identifier of fraud detection scenario'), country_org_cd
OPTIONS(description='The code of the business country_2 for which the related country_2 organization is responsible. (The business country_2 is not identical to a political country.)'),
store_sid
OPTIONS(description='The unique identifier (surrogate key) for the store where the related cash register event happened.'),
bus_dt OPTIONS(description='The business date on which the retail event is counted.'), cashier_nr
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
cash_register_event_cnt
OPTIONS(description='This column shows how much cash register events are relevant (default value is 1)'),
cash_register_event_affected_line_cnt
OPTIONS(description='Count of the cash register event lines for a particular scenario '),
cash_register_event_affected_net_val
OPTIONS(description='Sum of the cash register event lines for a particular scenario '), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS TABLE LISTS LINK CASH REGISTER EVENT TO ALL FRAUD SCENARIOUS WHICH APPLIES TO THIS EVENT`)
AS SELECT CAST(cash_register_event_sid AS STRING) AS cash_register_event_sid,
 cash_register_event_nr,
 scenario_id,
 country_org_cd,
 store_sid,
 bus_dt,
 cashier_nr,
 cash_register_event_cnt,
 cash_register_event_affected_line_cnt,
 cash_register_event_affected_net_val,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_2 AS main;