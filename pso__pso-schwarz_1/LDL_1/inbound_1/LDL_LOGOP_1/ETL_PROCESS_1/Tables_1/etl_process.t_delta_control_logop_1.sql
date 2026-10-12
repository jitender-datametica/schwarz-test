/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table/view	|	t_delta_control_logop_1
Description		|	ETL table to keep the maximum timestamp of extraction.
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_delta_control_logop_1 (
	src_table 			VARCHAR(100) 	NOT NULL 	COMMENT 'Source table', 
	src_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	max_extraction_tmsp	TIMESTAMP 		NOT NULL 	COMMENT 'The maximum extraction timestamp of previous load',
	PRIMARY KEY (src_table, src_system)
) COMMENT = 'ETL table to keep the maximum timestamp of extraction.'
;