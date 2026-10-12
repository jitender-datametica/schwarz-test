CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_cal_date_adjustment_type (
cal_dt_adjust_type_cd STRING(20) NOT NULL
OPTIONS(description='A code for the rule, which defines, how a calendar date is related to its equivalent day(s) in the previous year(s).'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
cal_dt_adjust_type_descr STRING(250) NOT NULL
OPTIONS(description='A description of the rule, how a calendar date is related to its equivalent day(s) in the previous year(s).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cal_dt_adjust_type_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the rules, which describe, how a date is related to its equivalent date(s) in the previous year(s). In case of leap years this may result in a many-to-many relationship. One rule is used on month-level. E.g. 28th of February 2021 is mapped to both 28th and 29 of February 2020. Another rule maps the 28 of February 2021 to both March 1st and March 2nd of 2019, so that the integrity of business years is maintained.');