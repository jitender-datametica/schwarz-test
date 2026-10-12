CREATE TABLE META.T_SEC_CONF_MSTR_USER_GROUP_TO_OBJECT (
    mstr_bus_user_grp_sid               NUMERIC(38,0)   NOT NULL COMMENT 'The surrogate key of business user groups will be created in MicroStrategy Environment' 
  , mstr_obj_sid                        NUMERIC(38,0)   NOT NULL COMMENT 'The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups' 
  , conf_active_from_dt                 DATE            NOT NULL COMMENT 'The point in time when this record became valid.' 
  , conf_active_to_dt                   DATE            NOT NULL COMMENT 'The point in time when this record was no longer valid.' 
  , conf_active_fg                      BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between conf_valid_from and conf_valid_to.' 
  , request_status_cd                   VARCHAR(20)     NOT NULL COMMENT 'The status of a grant status if it is approved, requested or denied.' 
  , granted_fg                          BOOLEAN         NOT NULL COMMENT 'The value of granted flag, if a user group has an access or not' 
  , requestor_user_name                 VARCHAR(100)    NOT NULL COMMENT 'The MSTR-User who enters the value to the system' 
  , request_tmsp                        TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point of the time, when the entry is done.' 
  , approver_user_name                  VARCHAR(100)    COMMENT 'The MSTR-User who approves the value entered to the system' 
  , approved_tmsp                       TIMESTAMP_TZ(9) COMMENT 'The point of the time when the entry is approved.' 
  , CONSTRAINT PK_T_SEC_CONF_MSTR_USER_GROUP_TO_OBJECT PRIMARY KEY (mstr_bus_user_grp_sid, mstr_obj_sid, conf_active_from_dt) NOT ENFORCED
 )  COMMENT= 'The relationship table which contains the information which user is allowed to access which object ( Report,Dossier, Metric ACL)';
