CREATE TABLE META.T_SEC_CONF_PREDICATE_PARAMETER_1 (
    predicate_param_name                VARCHAR(255)    NOT NULL COMMENT 'The predicate is created for varios values and this column specifies how the value of a condition is set in predicate. E.g. to determine Iso code value for a country_1 of a predicate as in Land_1@ISO= DE ' 
  , conf_tmsp                           TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the configuration is updated or inserted' 
  , CONSTRAINT PK_T_SEC_CONF_PREDICATE_PARAMETER PRIMARY KEY (predicate_param_name) NOT ENFORCED
 )  COMMENT= 'The table which contains list of predicate parameter values';