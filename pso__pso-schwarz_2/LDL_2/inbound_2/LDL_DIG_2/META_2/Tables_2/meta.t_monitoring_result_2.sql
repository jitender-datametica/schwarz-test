CREATE TABLE META.T_MONITORING_RESULT_2 (
    MONITORING_RESULT_ID INT IDENTITY(1,1) NOT NULL COMMENT 'The unique identifier',
	MONITORING_EXECUTION_ID INT NOT NULL COMMENT 'The monitoring execution identifier',
	MONITORING_GROUP_ID INT NOT NULL COMMENT 'The monitoring group identifier',
	MONITORING_QUERY_ID INT NOT NULL COMMENT 'The monitoring query identifier',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	NAME VARCHAR(250) NOT NULL COMMENT 'The name of executed check.',
	INFO VARCHAR(250) COMMENT 'Additional check information.',
	RESULT VARCHAR(250) NOT NULL COMMENT 'The result of query.',
	RESCODE VARCHAR(10) NOT NULL COMMENT 'The result of checking: FAILURE, ERROR, WARNING, OK, ... .'
) COMMENT = 'Results of testing queries';