CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_fraud_detection_suspicious_cash_register_event_1 (cash_register_event_sid
OPTIONS(description='The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.'),
cash_register_event_nr
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_1-cycled after some time.'),
scenario_id OPTIONS(description='The unique identifier of fraud detection scenario'), fraud_analysis_status_cd
OPTIONS(description='The are different status_1 codes.First status_1 code comes: SP-suspicious and then maybe later on NSP- not suspicious'),
comment_tnx OPTIONS(description='Describes why the user was clasified the record ( true or  false)'), bus_dt
OPTIONS(description='The business date on which the retail event is counted.'), store_sid
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
cashier_nr
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
marked_by_user_name OPTIONS(description='The MicroStrategy-User who marked the receipt'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `FROM BUSINESS USER MARKED RECEIPTS, WHICH FROM HIS VIEW OF POINT ARE SUSPICIOUS`) AS SELECT CAST(cash_register_event_sid AS STRING)
 AS cash_register_event_sid,
 ROUND(CAST(RIGHT(SUBSTR(CAST(cash_register_event_sid AS STRING), 1, 39), 10) AS BIGNUMERIC), 0) AS
 cash_register_event_nr,
 scenario_id,
 fraud_analysis_status_cd,
 comment_tnx,
 bus_dt,
 store_sid,
 cashier_nr,
 marked_by_user_name,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_core_app_fraud_detection.t_fraud_detection_suspicious_cash_register_event_1 AS MAIN;