CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_conf_predicate_parameter_1 (
predicate_param_name STRING(255) NOT NULL
OPTIONS(description='The predicate is created for varios values and this column specifies how the value of a condition is set in predicate. E.g. to determine Iso code value for a country_1 of a predicate as in Land_1@ISO= DE '),
conf_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp, the configuration is updated or inserted'),
PRIMARY KEY (predicate_param_name) NOT ENFORCED
) OPTIONS(description='The table which contains list of predicate parameter values');