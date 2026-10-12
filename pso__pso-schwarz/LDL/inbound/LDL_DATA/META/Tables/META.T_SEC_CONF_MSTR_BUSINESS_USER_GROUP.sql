CREATE TABLE META.T_SEC_CONF_MSTR_BUSINESS_USER_GROUP (
    mstr_bus_user_grp_sid               NUMERIC(38,0)   NOT NULL COMMENT 'The surrogate key of business user groups will be created in MicroStrategy Environment' 
 ,  mstr_bus_user_grp_nr                VARCHAR(32)     COMMENT 'The User Group ID, which represents the GUID from MicroStrategy-Metadata' 
 ,  mstr_bus_user_grp_name              VARCHAR(255)    NOT NULL COMMENT 'The Name of the MicroStrategy User Group default metadata language' 
 ,  mstr_bus_user_grp_siam_name         VARCHAR(255)    NOT NULL COMMENT 'The Name of the MicroStrategy User Group in SIAM default metadata language' 
 ,  user_grp_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The Type of the Business User Group, if it is Ressort or Functional Group.' 
 ,  conf_tmsp                           TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the configuration is updated or inserted' 
 ,  CONSTRAINT PK_T_SEC_CONF_MSTR_BUSINESS_USER_GROUP PRIMARY KEY (mstr_bus_user_grp_sid) NOT ENFORCED
 )  COMMENT= 'The configuration table which contains the information about business user groups for object security';
