CREATE TABLE META.T_SEC_CONF_MSTR_FILTER_PREDICATE_1 (
    mstr_proj_nr                        VARCHAR(32)     NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata' 
 ,  mstr_predicate_name                 VARCHAR(255)    NOT NULL COMMENT 'The name of predicate (behaves like identifier)' 
 ,  predicate_type_cd                   VARCHAR(20)     NOT NULL COMMENT 'The type of predicate automic when it is real condition is and complex when it is built on two other predicates' 
 ,  mstr_predicate_left_child_name      VARCHAR(255)    COMMENT 'The name of the predicate on left side for complex predicates : <LEFT Predicate> <AND/OR> <RIGHT Predicate>' 
 ,  mstr_predicate_right_child_name     VARCHAR(255)    COMMENT 'The name of the predicate on right side for complex predicates : <LEFT Predicate> <AND/OR> <RIGHT Predicate>' 
 ,  predicate_function_nr               VARCHAR(255)    COMMENT 'The function for the automic predicates like Equals, Greater, In ... ' 
 ,  mstr_attr_unique_nr                 VARCHAR(512)    COMMENT 'The Unique Id of the row via concetanation of Project ID,Attribute ID and Attribute form name' 
 ,  mstr_attr_nr                        VARCHAR(32)     COMMENT 'The Attribute ID, which represents the GUID from MicroStrategy-Metadata' 
 ,  mstr_attr_name                      VARCHAR(255)    COMMENT 'The Name of the attribute in default metadata language of project' 
 ,  mstr_attr_form_name                 VARCHAR(255)    COMMENT 'The Name of the attribute form name in default metadata language of project' 
 ,  mstr_attr_form_name_datatype_cd     VARCHAR(255)    COMMENT 'The Data type of the attribute form like string, number (it is set via list from frontend)' 
 ,  predicate_param_name                VARCHAR(255)    COMMENT 'The predicate is created for varios values and this column specifies how the value of a condition is set in predicate. E.g. to determine Iso code value for a country_1 of a predicate as in Land_1@ISO= DE ' 
 ,  conf_tmsp                           TIMESTAMP_LTZ(9) COMMENT 'The timestamp, the configuration is updated or inserted' 
 ,  CONSTRAINT PK_T_SEC_CONF_MSTR_FILTER_PREDICATE PRIMARY KEY (mstr_proj_nr, mstr_predicate_name) NOT ENFORCED
 )  COMMENT= 'The configuration table which contains the information about a predicate of security filter, how a filter condition will be created';
