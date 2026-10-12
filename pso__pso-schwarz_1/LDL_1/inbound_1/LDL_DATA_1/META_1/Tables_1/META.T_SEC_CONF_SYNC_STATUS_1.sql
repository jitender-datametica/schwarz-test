CREATE TABLE META.T_SEC_CONF_SYNC_STATUS_1 (
    sync_status_cd                      VARCHAR(20)     NOT NULL COMMENT 'The status_1 of the synchronisation status_1 successful or error' 
  , sync_status_descr                   VARCHAR(250)    NOT NULL COMMENT 'The description of  the synchronisation status_1 ' 
  , CONSTRAINT PK_T_SEC_CONF_SYNC_STATUS PRIMARY KEY (sync_status_cd) NOT ENFORCED
 )  COMMENT= 'The status_1 of sync, if it is sucess or error is';