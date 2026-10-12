CREATE TABLE META.T_SEC_CONF_MSTR_PROJECT_ATTRIBUTE (
    mstr_attr_unique_nr                 VARCHAR(512)    NOT NULL COMMENT 'The Unique Id of the row via concetanation of Project ID,Attribute ID and Attribute form name' 
  , mstr_proj_nr                        VARCHAR(32)     NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata' 
  , mstr_attr_nr                        VARCHAR(32)     NOT NULL COMMENT 'The Attribute ID, which represents the GUID from MicroStrategy-Metadata' 
  , mstr_attr_name                      VARCHAR(255)    NOT NULL COMMENT 'The Name of the attribute in default metadata language of project' 
  , mstr_attr_form_name                 VARCHAR(255)    NOT NULL COMMENT 'The Name of the attribute form name in default metadata language of project' 
  , mstr_attr_form_name_datatype_cd     VARCHAR(255)    NOT NULL COMMENT 'The Data type of the attribute form like string, number (it is set via list from frontend)' 
  , conf_tmsp                           TIMESTAMP_LTZ(9) COMMENT 'The timestamp, the configuration is updated or inserted' 
  , CONSTRAINT PK_T_SEC_CONF_MSTR_PROJECT_ATTRIBUTE PRIMARY KEY (mstr_attr_unique_nr) NOT ENFORCED
 )  COMMENT= 'The configuration table which contains the necessary attributes/attribute forms to create security filters';
