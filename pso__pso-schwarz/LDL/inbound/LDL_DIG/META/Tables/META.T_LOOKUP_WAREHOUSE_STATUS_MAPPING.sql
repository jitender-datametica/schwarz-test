CREATE TABLE META.T_LOOKUP_WAREHOUSE_STATUS_MAPPING
(
	WH_CD 					VARCHAR(5)	COMMENT 'Warehouse Code',
	STATUSTYPE    			VARCHAR(10) COMMENT 'Status Type', 
	STATUSCODE    			VARCHAR(3) COMMENT 'Status Type Code', 
	PROCESSTYPE 			VARCHAR(10) COMMENT 'Process Type',
	IS_IN_PROGRESS_TASK_FG 	BOOLEAN COMMENT 'This field indicates whether the warehouse order number and its associated tasks and waves are currently in progress. Based on this flag, the values are being taken into consideration within the Lager Cockpit or not',
	TMSP_INSERT    			TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was inserted.',
	TMSP_UPDATE    			TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last updated.'
);