CREATE TABLE META.T_SEC_CONF_MSTR_USER_GROUP_TYPE (
    user_grp_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The type of the user group technical or business is' 
  , user_grp_type_descr                 VARCHAR(250)    NOT NULL COMMENT 'The description of  user group type' 
  , CONSTRAINT PK_T_SEC_CONF_MSTR_USER_GROUP_TYPE PRIMARY KEY (user_grp_type_cd) NOT ENFORCED
 )  COMMENT= 'The user group type, if the user group is business or techical relevant';