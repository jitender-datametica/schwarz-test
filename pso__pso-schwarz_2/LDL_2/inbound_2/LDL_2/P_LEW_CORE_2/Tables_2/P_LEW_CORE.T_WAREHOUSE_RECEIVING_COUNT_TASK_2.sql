create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_WAREHOUSE_RECEIVING_COUNT_TASK_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT.',
	WH_RCV_CNT_TASK_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate identifier to be created (country_2, warehouse, inbound delivery / TASKID and creation date is generally unique).',
	WH_LOC_SID NUMBER(38,0) NOT NULL COMMENT 'Warehouse; FK auf LOCATION.',
	WH_NR VARCHAR(100) NOT NULL COMMENT 'Business identifier of warehouses in WAWI source system.',
	TASK_NR VARCHAR(100) NOT NULL COMMENT 'Business identifier for receiving count task.',
	TASK_CREATED_DT DATE NOT NULL COMMENT 'Date when the receiving count task was created.',
	TASK_CREATED_TMSP TIMESTAMP_NTZ(9) COMMENT 'The point in time when the receiving count task was created.',
	CARRIER_DESCR VARCHAR(250) COMMENT 'Carrier description (used as free text in source). The carrier is the transportation company that transports the goods (Spediteur), not the supplier. It is a short free-text description written by the warehouse worker. This column shows the attempt to enter the carrier name.',
	TASK_STATUS_ID NUMBER(38,0) COMMENT 'Status_2 ID of the receiving count task like GR posted, rejected, not valid, open, etc.',
	DELIVERY_NOTE_NR VARCHAR(100) COMMENT 'Delivery note number that comes with the driver.',
	TASK_COMPLETED_DT DATE COMMENT 'Date when the receiving count task was completed.',
	TASK_COMPLETED_TMSP TIMESTAMP_NTZ(9) COMMENT 'The point in time when the receiving count task was completed.',
	EU_PALLET_CNT NUMBER(38,0) COMMENT 'Count of euro pallets received per task.',
	DD_PALLET_CNT NUMBER(38,0) COMMENT 'Count of duesseldorfer pallets received per task.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	constraint PK_T_WAREHOUSE_RECEIVING_COUNT_TASK primary key (WH_RCV_CNT_TASK_SID)
)COMMENT='Table contains counting task / inbound delivery of receiving pallet from suppliers, store returns, warehouse transfers to warehouses.\n             Source:\n             WAWI table T173_GinTask (TASKID)\n             EWM table /SCDL/DB_PROCH_I (Inbound Delivery ID - DOCID)'
;
