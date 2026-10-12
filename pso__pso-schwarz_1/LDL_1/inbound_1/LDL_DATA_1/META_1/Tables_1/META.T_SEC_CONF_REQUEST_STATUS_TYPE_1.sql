CREATE TABLE META.T_SEC_CONF_REQUEST_STATUS_TYPE_1 (
    request_status_cd                   VARCHAR(20)     NOT NULL COMMENT 'The status_1 of a grant status_1 if it is approved, requested or denied.' 
  , request_status_descr                VARCHAR(250)    NOT NULL COMMENT 'The description of request status_1' 
  , CONSTRAINT PK_T_SEC_CONF_REQUEST_STATUS_TYPE PRIMARY KEY (request_status_cd) NOT ENFORCED
 )  COMMENT= 'The entity definies the lifecycle of the granting an object to an user group.';