CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_CASH_REGISTER_EVENT_CLASSIFICATION_1(
	CASH_REGISTER_EVENT_SID COMMENT 'The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.',
	CASH_REGISTER_EVENT_NR COMMENT 'The sequence number of the cash register transaction. It is unique to the cash register, but might be re_1-cycled after some time.',
	SCENARIO_ID COMMENT 'The unique identifier of fraud detection scenario',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_1 for which the related country_1 organization is responsible. (The business country_1 is not identical to a political country.)',
	STORE_SID COMMENT 'The unique identifier (surrogate key) for the store where the related cash register event happened.',
	BUS_DT COMMENT 'The business date on which the retail event is counted.',
	CASHIER_NR COMMENT 'The number which identifies the cashier. (The number is unique for a given store and a day.)',
	CASH_REGISTER_EVENT_CNT COMMENT 'This column shows how much cash register events are relevant (default value is 1)',
	CASH_REGISTER_EVENT_AFFECTED_LINE_CNT COMMENT 'Count of the cash register event lines for a particular scenario ',
	CASH_REGISTER_EVENT_AFFECTED_NET_VAL COMMENT 'Sum of the cash register event lines for a particular scenario ',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This table lists link cash register event to all fraud scenarious which applies to this event'
AS SELECT 
	main.cash_register_event_sid::VARCHAR(100) AS cash_register_event_sid
	,main.cash_register_event_nr
	,main.scenario_id
	,main.country_org_cd
	,main.store_sid
	,main.bus_dt
	,main.cashier_nr
	,main.cash_register_event_cnt
	,main.cash_register_event_affected_line_cnt
	,main.cash_register_event_affected_net_val
	,main.dwh_created_tmsp
	,main.dwh_updated_tmsp
	,main.dwh_load_id
	,main.dwh_node_cd
FROM CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_1 main;
