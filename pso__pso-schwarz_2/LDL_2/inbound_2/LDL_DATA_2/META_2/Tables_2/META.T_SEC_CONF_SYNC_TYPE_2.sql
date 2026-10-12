CREATE TABLE META.T_SEC_CONF_SYNC_TYPE_2 (
    sync_type_cd                        VARCHAR(20)     NOT NULL COMMENT 'The type of the synchronisation as revode or grant' 
  , sync_type_descr                     VARCHAR(250)    NOT NULL COMMENT 'The description of  the synchronisation type ' 
  , CONSTRAINT PK_T_SEC_CONF_SYNC_TYPE PRIMARY KEY (sync_type_cd) NOT ENFORCED
 )  COMMENT= 'The type of sync, if it is a grant or revoke is';
