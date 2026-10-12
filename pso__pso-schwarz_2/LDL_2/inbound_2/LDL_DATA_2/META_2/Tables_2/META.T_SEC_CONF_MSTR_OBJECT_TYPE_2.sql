CREATE TABLE META.T_SEC_CONF_MSTR_OBJECT_TYPE_2 (
    obj_type_cd                         VARCHAR(20)     NOT NULL COMMENT 'The type of the object report or metric user group' 
  , obj_type_descr                      VARCHAR(250)    NOT NULL COMMENT 'The description of  microstrategy object type' 
  , CONSTRAINT PK_T_SEC_CONF_MSTR_OBJECT_TYPE PRIMARY KEY (obj_type_cd) NOT ENFORCED
 )  COMMENT= 'The user group type, if the user group is business or techical relevant';