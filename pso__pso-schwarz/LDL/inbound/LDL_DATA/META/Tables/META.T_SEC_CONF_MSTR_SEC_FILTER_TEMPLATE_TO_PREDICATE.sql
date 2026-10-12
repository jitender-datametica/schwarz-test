CREATE TABLE META.T_SEC_CONF_MSTR_SEC_FILTER_TEMPLATE_TO_PREDICATE (
    mstr_proj_nr                        VARCHAR(32)     NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata' 
  , mstr_sec_filter_template_name       VARCHAR(255)    NOT NULL COMMENT 'The name of the security filter (also kind of Identifier)' 
  , mstr_predicate_name                 VARCHAR(255)    NOT NULL COMMENT 'The name of predicate (behaves like identifier)' 
  , conf_tmsp                           TIMESTAMP_LTZ(9) COMMENT 'The timestamp, the configuration is updated or inserted' 
  , CONSTRAINT PK_T_SEC_CONF_MSTR_SEC_FILTER_TEMPLATE_TO_PREDICATE PRIMARY KEY (mstr_proj_nr, mstr_sec_filter_template_name, mstr_predicate_name) NOT ENFORCED
 )  COMMENT= 'The configuration table which contains the relationship which security filter to its predicates';
