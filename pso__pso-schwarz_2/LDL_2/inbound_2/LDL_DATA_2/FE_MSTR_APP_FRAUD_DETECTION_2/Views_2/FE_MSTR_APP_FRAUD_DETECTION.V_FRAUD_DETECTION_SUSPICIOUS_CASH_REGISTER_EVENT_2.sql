CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_SUSPICIOUS_CASH_REGISTER_EVENT_2(
	CASH_REGISTER_EVENT_SID COMMENT 'The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.',
	CASH_REGISTER_EVENT_NR COMMENT 'The sequence number of the cash register transaction. It is unique to the cash register, but might be re_2-cycled after some time.',
	SCENARIO_ID COMMENT 'The unique identifier of fraud detection scenario',
	FRAUD_ANALYSIS_STATUS_CD COMMENT 'The are different status_2 codes.First status_2 code comes: SP-suspicious and then maybe later on NSP- not suspicious',
	COMMENT_TNX COMMENT 'Describes why the user was clasified the record ( true or  false)',
	BUS_DT COMMENT 'The business date on which the retail event is counted.',
	STORE_SID COMMENT 'The unique identifier (surrogate key) for the store where the related retail event happend.',
	CASHIER_NR COMMENT 'The number which identifies the cashier. (The number is unique for a given store and a day.)',
	MARKED_BY_USER_NAME COMMENT 'The MicroStrategy-User who marked the receipt',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'From Business User marked receipts, which from his view of point are suspicious'
AS SELECT 
main.cash_register_event_sid::VARCHAR(100) AS cash_register_event_sid
,RIGHT(main.cash_register_event_sid,10)::NUMBER AS cash_register_event_nr
,main.scenario_id
,main.fraud_analysis_status_cd
,main.comment_tnx
,main.bus_dt
,main.store_sid
,main.cashier_nr
,main.marked_by_user_name
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SUSPICIOUS_CASH_REGISTER_EVENT_2 main;