CREATE TABLE META.T_SEC_CONF_LOG_TYPE (
  LOG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The type of the log type like information, debug or error'
, LOG_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'The log type descripton'
, CONSTRAINT PK_T_SEC_CONF_LOG_TYPE PRIMARY KEY (LOG_TYPE_CD) NOT ENFORCED
) COMMENT= 'The status of sync, if it is sucess or error is';