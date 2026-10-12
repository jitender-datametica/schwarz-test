create or replace TABLE LDL_DATA_PRODUCTION.META.T_SEC_CONF_PREDICATE_PARAMETER (
	PREDICATE_PARAM_NAME VARCHAR(255) NOT NULL COMMENT 'The predicate is created for varios values and this column specifies how the value of a condition is set in predicate. E.g. to determine Iso code value for a country of a predicate as in Land@ISO= DE ',
	CONF_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the configuration is updated or inserted',
	constraint PK_T_SEC_CONF_PREDICATE_PARAMETER primary key (PREDICATE_PARAM_NAME)
)COMMENT='The table which contains list of predicate parameter values'
;